//
//  ScheduleCell.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var startEnd: UILabel!
    
    func configureCell(event: Event) {
        title.text = event.title
        startEnd.text = "\(event.startTime) - \(event.endTime)"
    }
}
