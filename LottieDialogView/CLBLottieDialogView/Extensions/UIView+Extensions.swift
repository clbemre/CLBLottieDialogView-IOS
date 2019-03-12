//
//  UIView+Extensions.swift
//  LottieDialogView
//
//  Created by Emre Celebi  on 12.03.2019.
//  Copyright © 2019 cLB. All rights reserved.
//

import UIKit

extension UIView {
    
    func defaultShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0
        layer.masksToBounds = false
    }
}
