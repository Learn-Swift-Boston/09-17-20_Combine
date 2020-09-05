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
    case zev = 0
    case matt
}

enum Email: String {
    case zev = "zev@zeveisenberg.com"
    case matt = "mdiasdeveloper@gmail.com"
}

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    var calls: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getImage(for: .zev)
    }
    
    deinit {
        calls = []
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        guard let segment = Segment(rawValue: sender.selectedSegmentIndex) else { return }
        
        getImage(for: segment)
    }
    
    func getImage(for segment: Segment) {
        var email: String
        
        switch segment {
        case .zev:
            email = Email.zev.rawValue
        case .matt:
            email = Email.matt.rawValue
        }
        
        APIClient().get(API.gravatar(email: email).url())
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    print("Couldn't get users: \(error)")
                case .finished: break
                }
            }) { image in
                self.imageView.image = image
        }.store(in: &calls)
    }
}

