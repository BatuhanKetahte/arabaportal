//
//  FirebaseImageService.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import Firebase

class FirebaseImageService {
    
    func getOtherUsersImage(username: String, completion: @escaping(Data) -> Void) {
        let storage = Storage.storage().reference(withPath: "profileImage/\(username).jpg")
        
        storage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                AppManager.shared.messagePresent(title: "OOPS", message: error.localizedDescription , type: .error, isInternet: .nonInternetAlert)
            } else {
                completion(data!)
            }
        }
    }

}
