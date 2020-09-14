//
//  ViewController.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import UIKit
import Combine

enum Segment: Int {
    case first = 0
    case second
}

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    private var cancellables: Set<AnyCancellable> = []
    private let client = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImage(for: .first)
    }
    
    deinit {
        cancellables = []
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let segment = Segment(rawValue: sender.selectedSegmentIndex) else { return }
        
        getImage(for: segment)
    }
    
    func getImage(for segment: Segment) {
        let client = APIClient()
        
        client.get(API.subreddit.url()) // first, get the list of posts
            .decode(type: Response.self, decoder: JSONDecoder())
            .map(\.imageUrls) // get out the image URLs we care about, which are of the form (index: Int, url: URL)
            .flatMap(self.getPublishersForURLS)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            }, receiveValue: { value in
                print(type(of: value))
                // put image in model
            })
            .store(in: &cancellables)
    }

  func getPublishersForURLS(_ indicesAndURLs: [(Int, URL)]) -> AnyPublisher<(Int, UIImage), Error> {
    // [].publisher creates an Publisher of Publishers of the Elements in the array
    return indicesAndURLs.publisher // Getting a Publishers.Sequence from an Array is how you do that
      .flatMap(self.getURLLatIndex) // Take the success output of the publisher and returns a new publisher with different output
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher() // outer pipeline has errors, so we need them too
  }

  func getURLLatIndex(index: Int, url: URL) -> AnyPublisher<(Int, UIImage), Never> {
      // Combine makes retain cycles easy to create. If you know a stream will complete once it's done doing
      // it's work capturing self is OK, but beware that you can create retain cycles with ease.
      self.client.get(url)
          .map(UIImage.init(data:))
          .replaceNil(with: UIImage(systemName: "photo")!)
          .replaceError(with: UIImage(systemName: "photo")!)
          .map { (index, $0) }
          .eraseToAnyPublisher()
  }
}

extension MutableCollection {
    subscript<T>(_ index: T) -> Element where T: RawRepresentable, T.RawValue == Index {
        get {
            self[index.rawValue]
        }
        set {
            self[index.rawValue] = newValue
        }
    }
}
