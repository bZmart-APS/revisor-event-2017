//
//  EventDetail.swift
//  revisorevent
//
//  Created by Alexander Steen on 02/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit
import CoreData

class EventDetail: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var companyImg: UIImageView!
    @IBOutlet weak var companyImgHeight: NSLayoutConstraint!
    @IBOutlet weak var speakerImg: UIImageView!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var devider: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    private var _event: Event!
    
    func setupView(event: Event) {
        _event = event
        
        speakerImg.layer.masksToBounds = false
        speakerImg.clipsToBounds = true
        speakerImg.layer.cornerRadius = speakerImg.frame.width / 2

        title.text = event.title
        descr.text = event.description
        timeLbl.text = "\(event.startTime) - \(event.endTime)"
        
        if event.companyImg != nil {
            let imgSize = event.companyImg?.size
            let ratio = (imgSize?.height)! / (imgSize?.width)!
            companyImgHeight.constant = companyImg.frame.width * ratio
            
            companyImg.image = event.companyImg
            companyImg.isHidden = false
            devider.isHidden = false
        } else {
            companyImg.isHidden = true
            devider.isHidden = true
        }
        
        if event.speakerImg != nil {
            speakerImg.image = event.speakerImg
            speakerImg.isHidden = false
        } else {
            speakerImg.isHidden = true
        }
        
        if event.speakerName != nil {
            speakerName.text = event.speakerName
            speakerName.isHidden = false
        } else {
            speakerName.isHidden = true
        }
        
        updateFavBtnState()
    }
    
    @IBAction func favPressed(_ sender: Any) {
        _event.toggleFav()
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
