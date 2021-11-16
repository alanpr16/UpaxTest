//
//  ParseHelper.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation

public final class ParserHelper {
    /// Parse result to a Object
    ///
    /// - Parameters:
    ///   - data: Data
    ///   - completion: Result<[T], ParserErrorResult>
    public static func parseObject<T: Decodable>(of type: T.Type, data: Any, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let object = try decoder.decode(T.self, from: jsonData)
            return .success(object)
        } catch {
            return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
        }
    }
}

