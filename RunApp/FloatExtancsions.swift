//
//  FloatExtancsions.swift
//  RunApp
//
//  Created by Evgen Patlay on 23.12.17.
//  Copyright © 2017 Evgen Patlay. All rights reserved.
//

import Foundation

extension Float {

    func timeRepresentation() -> String {
        let totalSec = self
        let totalsecmulti10: Int = Int(totalSec*10)
        let sec = totalsecmulti10 % 10
        let seca = (totalsecmulti10 / 10) % 60
        let min = totalsecmulti10 / 600 % 60
        let hour = totalsecmulti10 / 36000

        var hourStr = ""
        if (hour==0){
            hourStr = "00"
        }else if (hour < 10) {
            hourStr = "0\(hour)"
        }else { hourStr = "\(hour)"}

        var minStr = ""
        if (min==0){
            minStr = "00"
        }else if (min < 10) {
            minStr = "0\(min)"
        }else { minStr = "\(min)"}

        var secaStr = ""
        if (seca==0){
            secaStr = "00"
        }else if (seca < 10) {
            secaStr = "0\(seca)"
        }else { secaStr = "\(seca)"}

        return "\(hourStr):\(minStr):\(secaStr).\(sec)"

    }
}
