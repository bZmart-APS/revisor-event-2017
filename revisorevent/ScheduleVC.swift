//
//  ScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segControl: UISegmentedControl!
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let time = eventTimes[section].time
        let headerView = ScheduleHeader.fromNib()
        
        headerView.configureHeader(time: time)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = eventTimes[indexPath.section].events[indexPath.row]
        
        performSegue(withIdentifier: "EventDetails", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? EventDetailsVC {
            if let event = sender as? Event {
                dist.event = event
            }
        }
    }
    
    func createDummyData() {
        eventTimes.append(EventTime(time: "09:30", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 1), ("Title", "Registrering og morgenmad"), ("StartTime", "09:30"), ("EndTime", "10:00")))]))
        
        eventTimes.append(EventTime(time: "10:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 2), ("Title", "Velkomst"), ("StartTime", "10:00"), ("EndTime", "10:15"), ("Description", "Urs fra Penneo byder velkommen til dette års event."), ("SpeakerName", "Urs Kent"), ("SpeakerImg", UIImage(named: "urs_kent")!), ("CompanyImg", UIImage(named: "penneo")!)))]))
        
        eventTimes.append(EventTime(time: "10:15", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 3), ("Title", "Keynote"), ("StartTime", "10:15"), ("EndTime", "11:00"), ("Description", "Jacob Wandt, CEO i Zenegy, medstifter af e-conomic og revisor af baggrund, fortæller om sine erfaringer både som del af og leverandør til revisorbranchen."), ("SpeakerName", "Jacob Wandt"), ("SpeakerImg", UIImage(named: "jacob_wandt")!), ("CompanyImg", UIImage(named: "zenegy")!)))]))
        
        eventTimes.append(EventTime(time: "11:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 4), ("Title", "Pause"), ("StartTime", "11:00"), ("EndTime", "11:15"), ("SpeakerImg", UIImage(named: "coffee")!), ("Color", 0x88E498)))]))
        
        eventTimes.append(EventTime(time: "11:15", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 5), ("Title", "Workshop"), ("StartTime", "11:15"), ("EndTime", "13:00"), ("Description", "Få opdateret din faglige viden. Ole Aagesen fra Revitax fortæller mere om ...."), ("CompanyImg", UIImage(named: "workshop")!)))]))
        
        eventTimes.append(EventTime(time: "13:00", events: [Event(ownDict: Dictionary<String, Any>(dictionaryLiteral: ("Id", 6), ("Title", "Frokost"), ("StartTime", "13:00"), ("EndTime", "14:00"), ("Description", "Hotel Svendborg byder på en lækker buffet, lavet på udsøgte friske råvarer. Nyd frokosten i Restaurant Krinsen med mulighed for at sidde udenfor på vores hyggelige terrasse. Buffeten består af et STORT UDVALG af både forretter, hovedretter og desserter. ASJDKLAJSLKDJALKSDJLKAJSDKJALKSDJLKAJDLKJLAKSJDLKJASLKDJLKAJFKLJASLKDJLKASJDLKAJKLSDJAKLSJDKLASJDKLAJSLKDJKLAJSLKDJLKASJD"), ("CompanyImg", UIImage(named: "buffet")!)))]))
    }
}














