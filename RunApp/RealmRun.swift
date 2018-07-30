//
//  RealmRun.swift
//  
//
//  Created by Evgen Patlay on 23.12.17.
//

import Foundation
import RealmSwift
import Realm

class RealmRun: Object{

    @objc dynamic var distance: Double = 0
    @objc dynamic var time: String = ""
    @objc dynamic var speed: Double = 0
    @objc dynamic var date: NSDate = NSDate()

    init (distance: Double, time: String, speed: Double, date: NSDate) {
        super.init()
        self.distance = distance
        self.time = time
        self.speed = speed
        self.date = date
    }

    required init() {
        super.init()
        self.distance = 0
        self.time = ""
        self.speed = 0
        self.date = NSDate()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
       // fatalError("init(realm:schema:) has not been implemented")
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
        //fatalError("init(value:schema:) has not been implemented")
    }


}
