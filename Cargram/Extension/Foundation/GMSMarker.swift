//
//  GMSMarker.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import GoogleMaps

extension GMSMarker {
    var id: Int {
        set(id) {
            self.userData = id
        }

        get {
           return self.userData as! Int
       }
   }
}
