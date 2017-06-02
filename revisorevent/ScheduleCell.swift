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
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var startEnd: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var speakerNameLbl: UILabel!
    @IBOutlet weak var companyImg: UIImageView!
    
    var delegate: FavBtnPressedProtocol?
    
    private var _event: Event!
    
    func configureCell(event: Event) {
        speakerImg.layer.masksToBounds = false
        speakerImg.clipsToBounds = true
        speakerImg.layer.cornerRadius = speakerImg.frame.width / 2
        
        _event = event
        title.text = event.title
        startEnd.text = "\(event.startTime) - \(event.endTime)"
        if event.description == nil {
            descriptionLbl.isHidden = true
        } else {
            descriptionLbl.isHidden = false
            descriptionLbl.text = event.description
        }
        speakerImg.image = event.speakerImg
        companyImg.image = event.companyImg
        speakerNameLbl.text = event.speakerName

        updateFavBtnState()
    }
    
    @IBAction func favPressed(_ sender: Any) {
        _event.toggleFav()
        delegate?.pressedFavButton()
        updateFavBtnState()
    }
    
    func updateFavBtnState() {
        if checkIfFav() {
            favBtn.setImage(UIImage(named: "star-filled_TableView"))
        } else {
            favBtn.setImage(UIImage(named: "star-unfilled_TableView"))
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
