//
//  MeetingViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit
import CoreLocation

class MeetingViewModel {
    
    let firebase = FirebaseMeetingService()
    var eventArray: [EventModel] = []
    var upcomingArray: [EventModel] = []
    var endedArray: [EventModel] = []
    
    func fetchData(completion: @escaping(Void?,Error?) -> Void) {
        LoadingView.show()
        firebase.getEventDatas { [weak self] (eventArray, err) in
            if let error = err {
                completion(nil,error)
            } else {
                self?.eventArray = eventArray!
                completion((),nil)
            }
        }
    }
    
    func getUpcomingLabel() -> String {
        let selectedArray = eventArray.filter { ($0.timestamp - Double(Date().timeIntervalSince1970)) >= 0 }
        upcomingArray = selectedArray
        let counted = selectedArray.count
        return "Upcoming Events = \(counted)"
    }
    
    func getEndedLabel() -> String {
        let selectedArray = eventArray.filter { ($0.timestamp - Double(Date().timeIntervalSince1970)) < 0 }
        endedArray = selectedArray
        let counted = selectedArray.count
        return "Ended Events = \(counted)"
    }
}
