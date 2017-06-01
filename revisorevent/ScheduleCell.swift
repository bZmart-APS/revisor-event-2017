//
//  ScheduleCell.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import CoreData

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var startEnd: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    var delegate: FavBtnPressedProtocol?
    
    private var _event: Event!
    
    func configureCell(event: Event) {
        _event = event
        title.text = event.title
        startEnd.text = "\(event.startTime) - \(event.endTime)"
        updateFavBtnState()
    }
    
    @IBAction func favPressed(_ sender: Any) {
        _event.toggleFav()
        delegate?.pressedFavButton()
        updateFavBtnState()
    }
    
    func updateFavBtnState() {
        if checkIfFav() {
            favBtn.setTitle("Is Fav", for: .normal)
        } else {
            favBtn.setTitle("Not Fav", for: .normal)
        }
    }
    
    func checkIfFav() -> Bool {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = FavEvent.fetchRequest()
        do {
            let res = try context.fetch(request)
            return res.contains(where: { (value) -> Bool in
                if let favEvent = value as? FavEvent { return Int(favEvent.id) == self._event.id }
                return false
            })
        }catch{
            fatalError("Could not load FavEvents from core data")
        }
        
        return false
    }    
}
