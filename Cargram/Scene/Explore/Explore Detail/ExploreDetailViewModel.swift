//
//  ExploreDetailViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

final class ExploreDetailViewModel {
    
    lazy var titleData:ExploreModel? = nil
    lazy var exploreDetailArray:[ExploreDetailModel]? = []
    
    let firebase = FirebaseExploreService()
    
    internal func fetchData(completion: @escaping(Bool)->Void) {
        
        if let title = titleData?.title {
            firebase.getExploreDetails(title: title) { (data) in
                self.exploreDetailArray = data
                completion(true)
            }
        }
    }
    
}

