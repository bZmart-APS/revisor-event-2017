//
//  ScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleVC: UITableViewController {

    var eventTimes = [EventTime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (UIApplication.shared.delegate as! AppDelegate).setupTabBar()
                
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        eventTimes.append(EventTime(time: "08:00", events: [Event(id: 1, title: "Morgenmad", startTime: "08:00", endTime: "08:30"), Event(id: 2, title: "Brunch", startTime: "08:00", endTime: "09:00")]))
        eventTimes.append(EventTime(time: "08:30", events: [Event(id: 3,title: "Intro", startTime: "08:30", endTime: "09:30")]))
        eventTimes.append(EventTime(time: "09:30", events: [Event(id: 4, title: "Regnskab", startTime: "09:30", endTime: "10:30")]))
        eventTimes.append(EventTime(time: "10:45", events: [Event(id: 5, title: "Svendel", startTime: "10:45", endTime: "12:00")]))
        eventTimes.append(EventTime(time: "12:00", events: [Event(id: 6, title: "Farvel", startTime: "12:00", endTime: "12:15")]))
        
        eventTimes = Array(eventTimes).sorted(by: { $0.time < $1.time })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTimes[section].time
    }
}
