//
//  FavScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import CoreData

class FavScheduleVC: UITableViewController, FavBtnPressedProtocol {

    var eventTimes = [EventTime]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadFromCore()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return eventTimes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTimes[section].events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventTime = eventTimes[indexPath.section]
        let event = eventTime.events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
        cell.configureCell(event: event)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTimes[section].time
    }
    
    func pressedFavButton() {
        loadFromCore()
    }
    
    func loadFromCore() {
        eventTimes = [EventTime]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = FavEvent.fetchRequest()
        var result: [FavEvent]
        do {
            result = try context.fetch(request) as! [FavEvent]
        }catch{
            fatalError("Could not load FavEvents from core data")
        }

        for favEvent in result {
            
            let index = eventTimes.index(where: { (value) -> Bool in
                return value.time == favEvent.startTime!
            })
            if index != nil {
                let intIndex = eventTimes.startIndex.distance(to: index!)
                var events = eventTimes[intIndex].events
                events.append(Event(favEvent: favEvent))
                eventTimes[intIndex].events = events
            }else {
                eventTimes.append(EventTime(time: favEvent.startTime!, events: [Event(favEvent: favEvent)]))
            }
        
        }
        
        if eventTimes.count == 0 {
            let alertCon = UIAlertController(title: "No Fav", message: "You can add faves in schedule", preferredStyle: .alert)
            alertCon.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertCon, animated: true, completion: nil)
        } else {
            eventTimes = Array(eventTimes).sorted(by: { $0.time < $1.time })
        }
        
        tableView.reloadData()
    }
}
