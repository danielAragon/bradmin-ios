//
//  SessionsResponse.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
struct SessionsResponse: Decodable {
    var sessions: [Session]?
    var code: String?
    var message: String?
}
