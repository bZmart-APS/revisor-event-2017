//
//  ScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var eventTimes = [EventTime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        (UIApplication.shared.delegate as! AppDelegate).setupTabBar()
                
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        eventTimes.append(EventTime(time: "09:30", events: [Event(id: 1, title: "Registrering og morgenmad", startTime: "09:30", endTime: "10:00")]))
        eventTimes.append(EventTime(time: "10:00", events: [Event(id: 2,title: "Velkomst", startTime: "10:00", endTime: "10:15", description: "Urs fra Penneo byder velkommen til dette års event")]))
        eventTimes.append(EventTime(time: "10:15", events: [Event(id: 3, title: "Keynote", startTime: "10:15", endTime: "11:00")]))
        
        eventTimes = Array(eventTimes).sorted(by: { $0.time < $1.time })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventTimes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTimes[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventTime = eventTimes[indexPath.section]
        let event = eventTime.events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
        cell.configureCell(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTimes[section].time
    }
}
