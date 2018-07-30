//
//  Run.swift
//  RunApp
//
//  Created by Evgen Patlay on 02.12.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import Foundation

class Run: NSObject {
    var time: String
    var distance: Double
    var speed: Double
    let date: NSDate


    init(time: String, distance: Double, speed: Double, date: NSDate) {
        self.time = time
        self.distance = distance
        self.speed = speed
        self.date = date
    }
}
