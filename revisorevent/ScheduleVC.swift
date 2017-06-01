//
//  ScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleVC: UITableViewController {

    var events = [EventTime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        events.append(EventTime(time: "08:00", events: [Event(title: "Morgenmad", startTime: "08:00", endTime: "08:30"), Event(title: "Brunch", startTime: "08:00", endTime: "09:00")]))
        events.append(EventTime(time: "08:30", events: [Event(title: "Intro", startTime: "08:30", endTime: "09:30")]))
        events.append(EventTime(time: "09:30", events: [Event(title: "Regnskab", startTime: "09:30", endTime: "10:30")]))
        events.append(EventTime(time: "10:45", events: [Event(title: "Svendel", startTime: "10:45", endTime: "12:00")]))
        events.append(EventTime(time: "12:00", events: [Event(title: "Farvel", startTime: "12:00", endTime: "12:15")]))
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventTime = events[indexPath.section]
        let event = eventTime.events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
        cell.configureCell(event: event)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return events[section].time
    }
}
