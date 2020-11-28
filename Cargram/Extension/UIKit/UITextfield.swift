//
//  UITextfield.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

extension UITextField {
     func updatePlaceHolder(_ text: String, color: UIColor) {
         attributedPlaceholder = NSAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key.foregroundColor: color])
     }
 }
