//
//  MessageViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import Firebase

class MessageViewModel {
    
    let firebase = FirebaseForumService()
    
    lazy var messageModel: [MessageModel] = []
    
    func getMessage() {
        LoadingView.show()
        firebase.getSelectedTopicMessage { (response) in
            self.messageModel.removeAll()
            self.messageModel = response
        }
    }
    
    func sendMessage(message: String, completion: @escaping(Bool) -> Void) {
        if !message.isEmpty {
            firebase.sendMessageToTopic(message: message)
            completion(true)
        }
    }
    
    func getUserImage(userName:String, completion: @escaping(Data) -> Void) {
        firebase.getOtherUsersImage(username: userName) { (data) in
            completion(data)
        }
    }
}
