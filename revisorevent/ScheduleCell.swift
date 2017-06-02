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
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var speakerNameLbl: UILabel!
    @IBOutlet weak var companyImg: UIImageView!
    @IBOutlet weak var leftSideStack: UIStackView!
    @IBOutlet weak var speakerStack: UIStackView!
    
    var delegate: FavBtnPressedProtocol?
    
    private var _event: Event!
    
    func configureCell(event: Event) {
        speakerImg.layer.masksToBounds = false
        speakerImg.clipsToBounds = true
        speakerImg.layer.cornerRadius = speakerImg.frame.width / 2
    
        descriptionLbl.sizeToFit()
        
        _event = event
        title.text = event.title
        self.backgroundColor = _event.color
        
        descriptionLbl.numberOfLines = 2
        
        if event.description == nil {
            descriptionLbl.isHidden = true
        } else {
            descriptionLbl.isHidden = false
            descriptionLbl.text = event.description
        }
        
        if event.speakerImg == nil {
            speakerImg.isHidden = true
        } else {
            speakerImg.isHidden = false
            speakerImg.image = event.speakerImg
        }
        
        if event.companyImg == nil {
            companyImg.isHidden = true
        } else {
            companyImg.isHidden = false
            companyImg.image = event.companyImg
        }
        
        if !speakerImg.isHidden && !companyImg.isHidden {
            descriptionLbl.numberOfLines = 5
        }
        
        if event.speakerName == nil {
            speakerNameLbl.isHidden = true
        } else {
            speakerNameLbl.isHidden = false
            speakerNameLbl.text = event.speakerName
        }
        
        if speakerNameLbl.isHidden && speakerImg.isHidden && companyImg.isHidden {
            leftSideStack.isHidden = true
        } else {
            leftSideStack.isHidden = false
        }
        
        if speakerNameLbl.isHidden && speakerImg.isHidden {
            speakerStack.isHidden = true
        } else {
            speakerStack.isHidden = false
        }
        
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
