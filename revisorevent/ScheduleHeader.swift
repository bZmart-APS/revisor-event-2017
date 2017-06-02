//
//  ScheduleHeader.swift
//  revisorevent
//
//  Created by Alexander Steen on 02/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleHeader: UIView {
    
    @IBOutlet weak var timeLbl: UILabel!
    
    func configureHeader(time: String) {
        timeLbl.text = time
    }
    
}
