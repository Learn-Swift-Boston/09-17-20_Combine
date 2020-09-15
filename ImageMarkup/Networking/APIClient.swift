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
            .receive(on: queue) // ReceiveOn is telling Combine where you want to receive data, in this case I'm not sure this is what you want. If you want to perform background tasks, subscribe(on:) might be your choice. I honestly have only ever done `receive(on:)` for hopping back to main. http://trycombine.com/posts/subscribe-on-receive-on/
            .eraseToAnyPublisher()
    }
    
}
