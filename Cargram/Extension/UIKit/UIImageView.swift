//
//  UIImage.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeRoundWithBorder(borderColor: UIColor, borderWidth: Float, cornerRadius:Float) {
        layer.borderWidth = CGFloat(borderWidth)
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
        layer.cornerRadius = CGFloat(cornerRadius)
        layer.masksToBounds=true
    }
    
    func animate( images: [UIImage]) {
        isHidden = false
        animationImages = images
        animationDuration = 1.0
        animationRepeatCount = 1
        startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.isHidden = true
        }
    }
}
