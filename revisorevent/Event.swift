//
//  Event.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Event {
    
    private var _id: Int!
    private var _title: String!
    private var _startTime: String!
    private var _endTime: String!
    private var _description: String!
    
    var id: Int {
        return _id
    }
    
    var title: String {
        return _title
    }
    
    var startTime: String {
        return _startTime
    }
    
    var endTime: String {
        return _endTime
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    init(id: Int, title: String, startTime: String, endTime: String) {
        _id = id
        _title = title
        _startTime = startTime
        _endTime = endTime
    }
    
    init(id: Int, title: String, startTime: String, endTime: String, description: String) {
        _id = id
        _title = title
        _startTime = startTime
        _endTime = endTime
        _description = description
    }
    
    init(favEvent: FavEvent) {
        _id = Int(favEvent.id)
        _title = favEvent.title
        _startTime = favEvent.startTime
        _endTime = favEvent.endTime
        _description = favEvent.eventDescription
    }
    
    func toggleFav() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = FavEvent.fetchRequest()
        do {
            if let res = try context.fetch(request) as? [FavEvent] {
                for event in res {
                    if Int(event.id) == _id {
                        context.delete(event)
                        try context.save()
                        return
                    }
                }
            }
            addFavEventToContext(context)
            try context.save()
        }catch{
            fatalError("Could not load FavEvents from core data")
        }

    }
    
    private func addFavEventToContext(_ context: NSManagedObjectContext) {
        let favEvent = FavEvent(context: context)
        
        favEvent.id = Int32(_id)
        favEvent.title = _title
        favEvent.startTime = _startTime
        favEvent.endTime = _endTime
        favEvent.eventDescription = _description
    }
    
}
