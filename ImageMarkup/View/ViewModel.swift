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

    private let client = APIClient()

    /// get subreddit data, get the images in response order, and set them on `images` for display
    func getData() {
        // TODO: fill this in during the meetup
        
        // 1. get the list of posts as Response
        // 2. get out the image URLs we care about, which are of the form (index: Int, url: URL)
        // 3. get the UIImage for each url, in the of the form (index: Int, image: UIImage)
        // 4. set on self.images
    }

    /// loop over the indicesAndURLs creating publishers in `getIndexedImage(index: url:)`
    func getPublishersForURLS(_ indicesAndURLs: [(Int, URL)]) -> AnyPublisher<(Int, UIImage), Error> {
        // TODO: replace implementation during the meetup
        
        // [].publisher creates an Publisher of Publishers of the Elements in the array
        // Getting a Publishers.Sequence from an Array is how you do that
        // Take the success output of the publisher and returns a new publisher with different output
        // outer pipeline has errors, so we need them too
        Just((0, UIImage()))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    
    /// For a given index and URL, fetch the image at the URL and return it and its associated index
    func getIndexedImage(index: Int, url: URL) -> AnyPublisher<(Int, UIImage), Never> {
        // TODO: replace implementation during the meetup
        Just((0, UIImage()))
            .eraseToAnyPublisher()
    }
}
