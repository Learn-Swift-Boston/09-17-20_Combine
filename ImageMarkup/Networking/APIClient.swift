//
//  APIClient.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Combine
import Foundation
import UIKit.UIImage

class APIClient {
    func get(_ url: URL) -> AnyPublisher<UIImage, Never> {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceNil(with: UIImage())
            .replaceError(with: UIImage())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
