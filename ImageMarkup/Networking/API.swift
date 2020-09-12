//
//  API.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

enum API {
    case image(URL)
    case subreddit
}

extension API {
    func url() -> URL {
        switch self {
        case .image(let url):
            return url
        case .subreddit:
            return URL(string: "http://reddit.com/r/aww.json")!
        }
    }

}
