//
//  MoyaNetworkPlugin.swift
//  SmallworldTesr
//
//  Created by Aijaz Ali on 21/10/2023.
//

import Foundation
import Moya

enum MoyaNetworkPlugin {
    static let networkPlugin = NetworkActivityPlugin(networkActivityClosure: { changeType, _ in
        switch changeType {
        case .began:
            debugPrint("began")
        case .ended:
            debugPrint("ended")
        }
    })
}

class RequestInterceptor: PluginType {
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            debugPrint(response.debugDescription)
        case let .failure(error):
            debugPrint(error.localizedDescription)
        }
        
        switch result {
        case let .success(res):
            
            if res.data.statusCode  == 401 {
                // Logout app if we add login
            }
        default:
            break
        }
    }
    func willSend(_ request: RequestType, target: TargetType) {
        debugPrint(#function)
    }
}

extension TargetType {
    func getJsonAsData(from fileName: String) -> Data {
        guard let pathString = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return "{ \"data\" : [],\"message\" : \"Parsing Error\", \"status\" : 400 }"
                .data(using: String.Encoding.utf8) ?? Data()
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            return "{ \"data\" : [],\"message\" : \"Parsing Error\", \"status\" : 400 }"
                .data(using: String.Encoding.utf8) ?? Data()
        }
        debugPrint("The JSON string is: \(jsonString)")
        guard let jsonData = jsonString.data(using: .utf8) else {
            return "{ \"data\" : [],\"message\" : \"Parsing Error\", \"status\" : 400 }"
                .data(using: String.Encoding.utf8) ?? Data()
        }
        return jsonData
    }
    
    var defaultHeader: [String: String] {
        return ["Content-type": "application/json"]
    }
}
