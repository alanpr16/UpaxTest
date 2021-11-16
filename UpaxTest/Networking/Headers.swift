//
//  Headers.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation

struct Headers: Subscriptable {

    var collection: [HeaderName: String] = [:]

    init() {}

    subscript(index: HeaderName) -> String {
        get { return collection[index] ?? "" }
        set { collection[index] = newValue }
    }
}

enum HeaderName: String, Hashable {
    case contentType      = "Content-Type"
}
