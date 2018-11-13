//
//  BetterRideApi.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/7/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
import Alamofire

class BetterRideApi{
    static let baseUrl = "https://srv-desa.eastus2.cloudapp.azure.com/appbetterride/api/v1"
    static let getProjectsUrl = "\(baseUrl)/projects/supervisors/1"
    static let postProjectUrl = "\(baseUrl)/project"
    
    static func handleError(error: Error){
        print("Error while requesting Data: \(error.localizedDescription)")
    }
    
    static private func get<T: Decodable>(
        urlString: String,
        headers: [String: String],
        responseType: T.Type,
        responseHandler: @escaping ((T)-> (Void)),
        errorHandler: (@escaping (Error) -> (Void)) = handleError){
        Alamofire.request(urlString,
                          method: .get,
                          headers: headers)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    print("\(value)")
                    do{
                        let data = try
                            JSONSerialization.data(withJSONObject: value,
                                                   options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let dataResponse = try decoder.decode(responseType, from: data)
                        responseHandler(dataResponse)
                    }catch {
                        print("\(error)")
                    }
                case .failure(let error):
                    errorHandler(error)
                }
            })
        
        
    }
    
    static private func post<T: Decodable>(
        urlString: String,
        parameters: [String: Any],
        headers: [String: String],
        responseType: T.Type,
        responseHandler: @escaping ((T)-> (Void)),
        errorHandler: (@escaping (Error) -> (Void)) = handleError){
        Alamofire.request(urlString,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .httpBody),
                          headers: headers)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    print("\(value)")
                    do{
                        let data = try
                            JSONSerialization.data(withJSONObject: value,
                                                   options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let dataResponse = try decoder.decode(responseType, from: data)
                        responseHandler(dataResponse)
                    }catch {
                        print("\(error)")
                    }
                case .failure(let error):
                    errorHandler(error)
                }
            })
        
    }
    
    static func getProject(responseHandler: @escaping (ProjectsResponse) -> (Void),
                           errorHandler: @escaping (Error) -> (Void)){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: getProjectsUrl,
                 headers: headers,
                 responseType: ProjectsResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    
    static func postProject(fromProject project: Project?,
                            responseHandler: @escaping (PostResponse) -> (Void),
                            errorHandler: @escaping (Error) -> (Void)){
        let headers = ["token": "FG5325YGJM35"]
        if let project = project {
            let parameters = ["data": project]
            self.post(urlString: postProjectUrl,
                      parameters: parameters,
                      headers: headers,
                      responseType: PostResponse.self,
                      responseHandler: responseHandler,
                      errorHandler: errorHandler)
        }
    }
}
