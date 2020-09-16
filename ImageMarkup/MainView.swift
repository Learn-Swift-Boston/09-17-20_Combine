//
//  MainView.swift
//  ImageMarkup
//
//  Created by Matt Dias on 9/15/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    @State var images: [(Int, UIImage)] = []

    private var cancellables: Set<AnyCancellable> = []
    private let client = APIClient()

    var body: some View {
        VStack {
            Text("Viewing /r/aww")
            List(images, id: \.0) { indexImage in
                Image(uiImage: indexImage.1)
            }
            Button(action: getData) {
                Text("Fetch")
            }
        }
    }

    func getData() {

    }

//    mutating func getImage(for segment: Segment) {
//        client.get(API.subreddit.url()) // first, get the list of posts
//            .decode(type: Response.self, decoder: JSONDecoder())
//            .map(\.imageUrls) // get out the image URLs we care about, which are of the form (index: Int, url: URL)
//            .flatMap(self.getPublishersForURLS)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    print(error)
//                }
//            }, receiveValue: { value in
//                print(type(of: value))
//                // put image in model
//            })
//            .store(in: &cancellables)
//    }
//
//    func getPublishersForURLS(_ indicesAndURLs: [(Int, URL)]) -> AnyPublisher<(Int, UIImage), Error> {
//        // [].publisher creates an Publisher of Publishers of the Elements in the array
//        return indicesAndURLs.publisher // Getting a Publishers.Sequence from an Array is how you do that
//            .flatMap(self.getURLLatIndex) // Take the success output of the publisher and returns a new publisher with different output
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher() // outer pipeline has errors, so we need them too
//    }
//
//    func getURLatIndex(index: Int, url: URL) -> AnyPublisher<(Int, UIImage), Never> {
//        // Combine makes retain cycles easy to create. If you know a stream will complete once it's done doing
//        // it's work capturing self is OK, but beware that you can create retain cycles with ease.
//        self.client.get(url)
//            .map(UIImage.init(data:))
//            .replaceNil(with: UIImage(systemName: "photo")!)
//            .replaceError(with: UIImage(systemName: "photo")!)
//            .map { (index, $0) }
//            .eraseToAnyPublisher()
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
