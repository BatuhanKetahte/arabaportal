//
//  ShowMapViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class ShowMapViewModel {
    
    var doesPickerCardOnScreen = false
    var eventArray: [EventModel] = []
    
    func getLocationAddress(coordinate: CLLocationCoordinate2D, completion: @escaping(String) -> Void) {
        let geocoder = GMSGeocoder()
        var selectedAddress = ""
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let _ = address.lines
                else {
                    return
            }
            selectedAddress = address.lines![0]
            completion(selectedAddress)
        }
    }
    
}
