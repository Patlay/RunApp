//
//  StopWatch.swift
//  RunApp
//
//  Created by Evgen Patlay on 22.11.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import Foundation

class StopWatch {

    private var startTime: NSDate?

    var elapsdTime: TimeInterval{
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        }
        else{
            return 0
        }
    }
    var isRunning: Bool
    {
        return startTime != nil
    }
    func start()  {
        startTime = NSDate()
    }
    func stop()  {
        startTime = nil
    }
}
