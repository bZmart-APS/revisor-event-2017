//
//  UIButton.swift
//  revisorevent
//
//  Created by Alexander Steen on 01/06/2017.
//  Copyright © 2017 bZmart. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .application)
        setImage(image, for: .disabled)
        setImage(image, for: .focused)
        setImage(image, for: .highlighted)
        setImage(image, for: .reserved)
        setImage(image, for: .selected)
    }

}
