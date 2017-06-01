//
//  EventTime.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import Foundation

class EventTime {
    private var _time: String!
    private var _events: [Event]
    
    var time: String {
        return _time
    }
    
    var events: [Event] {
        return _events
    }
    
    init(time: String, events: [Event]) {
        _time = time
        _events = events
    }
}
