//
//  UIButton.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

extension UIButton {
    func setMyButton(title: String, color: UIColor, background: UIColor, borderColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        cornerRadius = 15
        backgroundColor = background
        layer.borderWidth = 3
        layer.borderColor = borderColor.cgColor
    }
}
