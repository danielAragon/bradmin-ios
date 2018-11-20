//
//  SupervisorResponse.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/20/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
struct SupervisorResponse: Decodable {
    var data: Supervisor?
    var code: String?
    var message: String?
}
