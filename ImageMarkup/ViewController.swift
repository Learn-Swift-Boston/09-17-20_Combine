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
            .flatMap { (indicesAndURLs: [(Int, URL)]) in // turn each URL into a publisher of the corresponding image
                indicesAndURLs.publisher // Getting a Publishers.Sequence from an Array is how you do that
                    .flatMap { (index, url) in // URL -> publisher of resulting image
                        client.get(url)
                            .map(UIImage.init(data:))
                            .replaceNil(with: UIImage(systemName: "photo")!)
                            .replaceError(with: UIImage(systemName: "photo")!)
                            .map { (index, $0) }
                    }
                    .setFailureType(to: Error.self) // outer pipeline has errors, so we need them too
        }
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
