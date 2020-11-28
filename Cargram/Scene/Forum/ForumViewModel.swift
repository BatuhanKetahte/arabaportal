//
//  ForumViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit

final class ForumViewModel {
    
    let categoriesName = ["Engine", "Brake", "Sound"]

    func setSelectedCategory(indexPath: Int) {
        AppManager.shared.selectedForumCategory = categoriesName[indexPath]
    }


}
