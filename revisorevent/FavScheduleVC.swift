//
//  FavScheduleVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import CoreData

class FavScheduleVC: UIViewController, UITableViewDelegate, UITableViewDataSource, FavBtnPressedProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var eventTimes = [EventTime]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadFromCore()
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTimes[section].time
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = eventTimes[indexPath.section].events[indexPath.row]
        
        performSegue(withIdentifier: "EventDetails", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? EventDetailsVC {
            if let event = sender as? Event {
                dist.delegate = self
                dist.event = event
            }
        }
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
