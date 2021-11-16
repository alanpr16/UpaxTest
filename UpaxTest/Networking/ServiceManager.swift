//
//  ServiceManager.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import Foundation

typealias ServiceModelResponse = APIResult<ServiceResponseModel?>

struct ServicesManager {
    // MARK: - Private properties
    private let networking = Networking()

    // MARK: - Inits
    init() { }

    func getGraphsInfo(completion: @escaping ServiceModelResponse) {
        let service = ServiceRequest.getInfoGraphs
        networking.fetchService(service: service) { result in
            completion(result)
        }
    }
}
