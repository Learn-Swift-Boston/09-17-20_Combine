//
//  ViewModel.swift
//  ImageMarkup
//
//  Created by Matt Dias on 9/15/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIImage

class ViewModel: ObservableObject {

    @Published var images: [(index: Int, image: UIImage)] = []

    private var cancellables: Set<AnyCancellable> = []
    private let client = APIClient()

    /// get subreddit data, get the images in response order, and set them on `images` for display
    func getData() {
        client.get(API.subreddit.url()) // first, get the list of posts
            .decode(type: Response.self, decoder: JSONDecoder())
            .map(\.imageUrls) // get out the image URLs we care about, which are of the form (index: Int, url: URL)
            .flatMap(self.getPublishersForURLS)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error) // TODO: handle errors more gracefully by showing error/empty state
                }
            }, receiveValue: { value in
                self.images.append(value)
            })
            .store(in: &cancellables)
    }

    /// loop over the indicesAndURLs creating publishers in `getIndexedImage(index: url:)`
    func getPublishersForURLS(_ indicesAndURLs: [(Int, URL)]) -> AnyPublisher<(Int, UIImage), Error> {
        // [].publisher creates an Publisher of Publishers of the Elements in the array
        return indicesAndURLs.publisher // Getting a Publishers.Sequence from an Array is how you do that
            .flatMap(self.getIndexedImage) // Take the success output of the publisher and returns a new publisher with different output
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher() // outer pipeline has errors, so we need them too
    }

    
    /// For a given index and URL, fetch the image at the URL and return it and its associated index
    func getIndexedImage(index: Int, url: URL) -> AnyPublisher<(Int, UIImage), Never> {
        // Combine makes retain cycles easy to create. If you know a stream will complete once it's done doing
        // its work capturing self is OK, but beware that you can create retain cycles with ease.
        self.client.get(url)
            .map(UIImage.init(data:))
            .replaceNil(with: UIImage(systemName: "photo")!)
            .replaceError(with: UIImage(systemName: "photo")!)
            .map { (index, $0) }
            .eraseToAnyPublisher()
    }
}
