//
//  ServiceRequest.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation

enum ServiceRequest: RequestProtocol {

    case getInfoGraphs

    var baseURL: URL {
        return URL(string: "https://us-central1-bibliotecadecontenido.cloudfunctions.net")!
    }

    var path: String {
        switch self {
        case .getInfoGraphs:
            return "/helloWorld"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getInfoGraphs:
            return .get
        }
    }

    var timeoutInterval: TimeInterval {
        return 30.0
    }

    var headers: Headers {
        var headers = Headers()
        headers[.contentType] = "application/json"
        return headers
    }

    var parameters: [String: Any] {
        switch self {
        case .getInfoGraphs:
            return [:]
        }
    }
}

