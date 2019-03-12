//
//  Utils.swift
//  LottieDialogView
//
//  Created by Emre Celebi  on 11.03.2019.
//  Copyright © 2019 cLB. All rights reserved.
//

import UIKit

class Utils {
    class func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    class func createUIButton() -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitleColor(Utils.hexStringToUIColor(hex: "#393939"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.backgroundColor = Utils.hexStringToUIColor(hex: "#e6e6e6").withAlphaComponent(0.5)
        // button.setBackgroundColor(color: Utils.hexStringToUIColor(hex: "#e6e6e6").withAlphaComponent(0.5), forState: .normal)
        // button.setBackgroundColor(color: UIColor.green, forState: UIControl.State.highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)

        return button
    }
}
