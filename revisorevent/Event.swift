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
    private var _description: String?
    private var _speakerName: String?
    private var _speakerImg: UIImage?
    private var _companyImg: UIImage?
    
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
    
    var speakerName: String? {
        return _speakerName
    }
    
    var description: String? {
        return _description
    }
    
    var speakerImg: UIImage? {
        return _speakerImg
    }
    
    var companyImg: UIImage? {
        return _companyImg
    }
    
    init(ownDict: Dictionary<String, Any>) {
        if let id = ownDict["Id"] as? Int { _id = id }
        if let title = ownDict["Title"] as? String { _title = title }
        if let startTime = ownDict["StartTime"] as? String { _startTime = startTime }
        if let endTime = ownDict["EndTime"] as? String { _endTime = endTime }
        if let description = ownDict["Description"] as? String { _description = description }
        if let speakerName = ownDict["SpeakerName"] as? String { _speakerName = speakerName }
        if let speakerImg = ownDict["SpeakerImg"] as? UIImage { _speakerImg = speakerImg }
        if let companyImg = ownDict["CompanyImg"] as? UIImage { _companyImg = companyImg }
    }
    
    init(favEvent: FavEvent) {
        _id = Int(favEvent.id)
        _title = favEvent.title
        _startTime = favEvent.startTime
        _endTime = favEvent.endTime
        _description = favEvent.eventDescription
        _speakerName = favEvent.speakerName
        if let speakerImg = favEvent.speakerImg as? UIImage {
            _speakerImg = speakerImg
        }
        if let companyImg = favEvent.companyImg as? UIImage {
            _companyImg = companyImg
        }
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
        favEvent.speakerImg = _speakerImg
        favEvent.companyImg = _companyImg
        favEvent.speakerName = _speakerName
    }
    
}
