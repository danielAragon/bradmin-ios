//
//  ProjectsResponse.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/7/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
struct ProjectsResponse: Decodable {
    var projects: [Project]?
    var code: String?
    var message: String?
}
