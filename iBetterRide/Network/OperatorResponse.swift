//
//  OperatorResponse.swift
//  iBetterRide
//
//  Created by Mauricio Rivas Arroyo on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
struct OperatorResponse: Decodable {
    var operators: [Operator]?
    var code: String?
    var message: String?
}
