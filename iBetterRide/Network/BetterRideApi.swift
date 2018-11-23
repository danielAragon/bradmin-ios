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
    static let getSessionsUrl = "\(baseUrl)/sessions/projects"
    static let postSessionUrl = "\(baseUrl)/session"
    static let getSupervisorUrl = "\(baseUrl)/users/1"
    static let getOperatorsInSessionUrl = "\(baseUrl)/userSession/sessions"
    static let getOperatorsNotInSessionUrl = "\(baseUrl)/userSession/noSessions"
    static let getOperatorsUrl = "\(baseUrl)/operators/organizations/1"
    static let postProfileSupervisorUrl = "\(baseUrl)/supervisors"
    
    static func handleError(error: Error){
        print("Error while requesting Data: \(error.localizedDescription)")
    }
    
    static private func get<T: Decodable>(
        urlString: String,
        headers: [String: String],
        responseType: T.Type,
        responseHandler: @escaping ((T)-> (Void)),
        errorHandler: (@escaping (Error) -> (Void))){
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
    
    static func getProject(responseHandler: @escaping (ProjectsResponse) -> (Void),
                           errorHandler: @escaping (Error) -> (Void)){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: getProjectsUrl,
                 headers: headers,
                 responseType: ProjectsResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    
    static func getSession(projectId id: String?,
                           responseHandler: @escaping (SessionsResponse) -> (Void),
                           errorHandler: (@escaping (Error) -> (Void)) = handleError){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: "\(getSessionsUrl)/\(id!)",
                 headers: headers,
                 responseType: SessionsResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    
    static func postProject(fromProject project: Project?){
        guard let endpointUrl = URL(string: postProjectUrl) else {
            print("Failed at url")
            return
        }
        do {
            let jsonEncoder = JSONEncoder ()
            let body = try jsonEncoder.encode(project!)
            var request = URLRequest(url: (endpointUrl))
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("1234", forHTTPHeaderField: "token")
            request.httpMethod = "POST"
            request.httpBody = body
            print("\(request)")
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("error")
                    return
                }
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("\(dataString!)")
            }
            task.resume()
        }catch{
            print("error")
        }
    }
    
    static func postSession(fromSession session: Session?){
        guard let endpointUrl = URL(string: postSessionUrl) else {
            print("Failed at url")
            return
        }
        do {
            let jsonEncoder = JSONEncoder ()
            let body = try jsonEncoder.encode(session!)
            var request = URLRequest(url: (endpointUrl))
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("1234", forHTTPHeaderField: "token")
            request.httpMethod = "POST"
            request.httpBody = body
            print("\(request)")
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("error")
                    return
                }
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("\(dataString!)")
            }
            task.resume()
        }catch{
            print("error")
        }
    }
    
    static func getOperator(responseHandler: @escaping (OperatorResponse) -> (Void),
                           errorHandler: (@escaping (Error) -> (Void)) = handleError){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: getOperatorsUrl,
                 headers: headers,
                 responseType: OperatorResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    static func getOperatorsInSession(responseHandler: @escaping (OperatorResponse) -> (Void),
                                      errorHandler: (@escaping (Error) -> (Void)) = handleError, sessionId: String){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: "\(getOperatorsInSessionUrl)/\(sessionId)",
                 headers: headers,
                 responseType: OperatorResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    static func getOperatorsNotInSession(responseHandler: @escaping (OperatorResponse) -> (Void),
                                      errorHandler: (@escaping (Error) -> (Void)) = handleError, sessionId: String){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: "\(getOperatorsNotInSessionUrl)/\(sessionId)",
            headers: headers,
            responseType: OperatorResponse.self,
            responseHandler: responseHandler,
            errorHandler: errorHandler)
    }
    
    static func getSupervisor(responseHandler: @escaping (SupervisorResponse) -> (Void),
                            errorHandler: (@escaping (Error) -> (Void)) = handleError){
        let headers = ["token": "FG5325YGJM35"]
        self.get(urlString: getSupervisorUrl,
                 headers: headers,
                 responseType: SupervisorResponse.self,
                 responseHandler: responseHandler,
                 errorHandler: errorHandler)
    }
    
    static func postProfileSupervisor(fromSession supervisor: Supervisor?){
        guard let endpointUrl = URL(string: postProfileSupervisorUrl) else {
            print("Failed at url")
            return
        }
        do {
            let jsonEncoder = JSONEncoder ()
            let body = try jsonEncoder.encode(supervisor!)
            var request = URLRequest(url: (endpointUrl))
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("FG5325YGJM35", forHTTPHeaderField: "token")
            request.httpMethod = "POST"
            request.httpBody = body
            print("\(request)")
            let task = URLSession.shared.dataTask(with: request){
                (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("error")
                    return
                }
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                print("\(dataString!)")
            }
            task.resume()
        }catch{
            print("error")
        }
    }
}
