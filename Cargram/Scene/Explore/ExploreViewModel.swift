//
//  ExploreViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

final class ExploreViewModel {

    let firebase  = FirebaseExploreService()
    lazy var exploreArray: [ExploreModel] = []
    
    func fetchExploreData(completion: @escaping(Bool) -> Void) {
        firebase.getExploreTopics { (responseArray) in
            self.exploreArray.removeAll()
            self.exploreArray = responseArray
            completion(true)
        }
    }
    
    func setSelectedRow(indexPath: Int) -> ExploreDetailViewController {
        let vc = ExploreDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.exploreDetailViewModel.titleData = exploreArray[indexPath]
        return vc
    }
}
