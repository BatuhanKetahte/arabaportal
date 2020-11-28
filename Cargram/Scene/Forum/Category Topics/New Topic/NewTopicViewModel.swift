//
//  NewTopicViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit
import Firebase

final class NewTopicViewModel {
    
    let firebase = FirebaseForumService()
    
    func createTopic(title: String, subTitle: String, check: Bool) {
        if title != "" && subTitle != "" {
            firebase.createTopicTitle(title: title, subtitle: subTitle, usernameController: check) { (_) in
                UIApplication.getPresentedViewController()?.dismiss(animated: true, completion: nil)
            }
        } else {
            errorAlert()
        }
    }
    
    func errorAlert() {
        AppManager.shared.messagePresent(title: "OOPS", message: "Please chech title and subtitle can't be empty", type: .error, isInternet: .nonInternetAlert)
    }
}
