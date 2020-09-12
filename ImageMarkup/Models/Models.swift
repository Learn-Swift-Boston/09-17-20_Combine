//
//  Models.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/12/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let data: ResponseData
}

// MARK: - ResponseData
struct ResponseData: Codable {
    let children: [Child]
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let postHint: PostHint
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case postHint = "post_hint"
        case url
    }
}

enum PostHint: String, Codable {
    case hostedVideo = "hosted:video"
    case image = "image"
    case link = "link"
    case richVideo = "rich:video"
}

extension Response {
    
    var imageUrls: [URL] {
        data.children
            .map(\.data)
            .filter { $0.postHint == .image }
            .map(\.url)
            .prefix(2)
            .toArray
    }
    
}

extension ArraySlice {
    var toArray: [Element] {
        Array(self)
    }
}
