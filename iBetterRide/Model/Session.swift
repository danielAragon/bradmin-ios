//
//  Session.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
struct Session : Codable {
    var id: String?
    var date: String?
    var started_at: String?
    var finished_at: String?
    var avenue_first: String?
    var avenue_second: String?
    var status: String?
    var project_id: String?
}
