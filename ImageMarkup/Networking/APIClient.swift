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
        // swap out befor meetup
//        Just(Data())
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
        session
            .dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { $0 as Error } // DataTaskPublisher has an output type of URLError, this discards extra information
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
    
}
