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
        
        createDummyData()
        
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
    
    func createDummyData() {
        eventTimes.append(EventTime(time: "09:30", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 1), ("Title", "Registrering og morgenmad"), ("StartTime", "09:30"), ("EndTime", "10:00")))]))
        
        eventTimes.append(EventTime(time: "10:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 2), ("Title", "Velkomst"), ("StartTime", "10:00"), ("EndTime", "10:15"), ("Description", "Urs fra Penneo byder velkommen til dette års event"), ("SpeakerName", "Urs Kent"), ("SpeakerImg", UIImage(named: "urs_kent")!), ("CompanyImg", UIImage(named: "penneo")!)))]))
        
        eventTimes.append(EventTime(time: "10:15", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 3), ("Title", "Keynote"), ("StartTime", "10:15"), ("EndTime", "11:00"), ("SpeakerName", "Jacob Wandt"), ("SpeakerImg", UIImage(named: "jacob_wandt")!)))]))
        
        eventTimes.append(EventTime(time: "11:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 4), ("Title", "Pause"), ("StartTime", "11:00"), ("EndTime", "11:15")))]))
        
        eventTimes.append(EventTime(time: "11:15", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 5), ("Title", "Workshop"), ("StartTime", "11:15"), ("EndTime", "13:00")))]))
        
        eventTimes.append(EventTime(time: "13:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 6), ("Title", "Frokost"), ("StartTime", "13:00"), ("EndTime", "14:00")))]))
    }
}














