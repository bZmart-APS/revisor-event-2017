//
//  EventDetailsVC.swift
//  revisorevent
//
//  Created by Alexander Steen on 02/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {

    @IBOutlet weak var xibView: UIView!
    
    var event: Event!
    var delegate: FavBtnPressedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventView = EventDetail.fromNib()
        eventView.setupView(event: event)
        
        xibView.addSubview(eventView)
    }
}
