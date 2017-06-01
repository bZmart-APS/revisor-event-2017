//
//  Event.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import Foundation

class Event {
    
    private var _title: String!
    private var _startTime: String!
    private var _endTime: String!
    
    var title: String {
        return _title
    }
    
    var startTime: String {
        return _startTime
    }
    
    var endTime: String {
        return _endTime
    }
    
    init(title: String, startTime: String, endTime: String) {
        _title = title
        _startTime = startTime
        _endTime = endTime
    }
    
}
