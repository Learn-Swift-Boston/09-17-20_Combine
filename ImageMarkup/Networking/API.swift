//
//  API.swift
//  ImageMarkup
//
//  Created by Matthew Dias on 9/5/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import Foundation
import CryptoKit

enum API {
    case gravatar(email: String)
}

extension API {
    func url() -> URL {
        switch self {
        case .gravatar(let email):
            return URL(string: "https://www.gravatar.com/avatar/\(Self.hash(email: email))")!
        }
    }
    
    static func hash(email: String) -> String {
        let tidiedEmail = email
            .trimmingCharacters(in: .whitespaces)
            .lowercased()
        let digest = Insecure.MD5.hash(data: tidiedEmail.data(using: .utf8) ?? Data())
        // https://stackoverflow.com/a/56578995
        return digest.map { thing in
            String(format: "%02hhx", thing)
        }.joined()
    }
}
