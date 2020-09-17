//
//  Models.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/12/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation

/*
 Models were generated with the help of https://app.quicktype.io
 */

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
    let postHint: PostHint?
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
    
    /// get URLs for images in a given Response and their index in the response
    var imageUrls: [(index: Int, url: URL)] {
        // TODO: fill this in during the meetup
        []
    }
    
}
