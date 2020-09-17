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
    static var queue = DispatchQueue(label: "network", qos: .userInitiated)
    
    func get(_ url: URL, session: URLSession = .shared, queue: DispatchQueue = APIClient.queue) -> AnyPublisher<Data, Error> {
        // TODO: replace implementation during the meetup
        
        Just(Data())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        // 1. fetch the data for a given URL
        // 2. ensure data is received on our queue for extra processing
    }
    
}
