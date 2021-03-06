//
//  ToDoCreateViewModel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

protocol ToDoCreated {
    func todoCreated()
}

final class ToDoCreateViewModel {
    
    var dataArray: [Data] = []
    var delegate: ToDoCreated?
    var didDateShow = false
    
    func deleteImage(index: Int) {
        dataArray.remove(at: index)
    }
    
    var center = UNUserNotificationCenter.current()
    
    
    func createTopic(title: String, subTitle: String, selectedDate: Date? = nil, completion: @escaping(Bool) -> Void) {
        if title != "" && subTitle != "" {
            let object = ToDoRealmModel()
            object.toDoTitle = title
            object.toDoDescription = subTitle
            if dataArray.isEmpty {
                object.picArray.append((UIImage(named: "gray")?.jpegData(compressionQuality: 0.5))!)
            } else {
                for data in dataArray {
                    object.picArray.append(data)
                }
            }
            
            let time = Double(selectedDate!.timeIntervalSince1970)
            object.deathline = time
            object.toDoDateShow = didDateShow
            
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(object)
                    self.createNotfications(title: title, time: time)
                }
            } catch {
                AppManager.shared.messagePresent(title: "OPPS", message: "Plan didn't saved", type: .error, isInternet: .nonInternetAlert)
            }
            
            delegate?.todoCreated()
            completion(true)
        } else {
            errorAlert()
        }
    }
    
    func errorAlert() {
        AppManager.shared.messagePresent(title: "OOPS", message: "Please chech title and subtitle can't be empty", type: .error, isInternet: .nonInternetAlert)
    }
    
    func setCollectionViewRow() -> Int {
        if dataArray.count == 0 {
            return 1
        } else {
            return dataArray.count+1
        }
    }
    
    func setCollectionViewCell(owner: ToDoCreateViewController, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != dataArray.count {
            switch dataArray.count {
            case 0:
                let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoAddCollectionViewCell", for: indexPath) as! ToDoAddCollectionViewCell
                cell.delegate = owner
                return cell
            default:
                let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoRemoveCollectionViewCell", for: indexPath) as! ToDoRemoveCollectionViewCell
                cell.button.backgroundColor = .clear
                cell.button.setImage(UIImage(data:  dataArray[indexPath.row]), for: .normal)
                cell.delegate = owner
                cell.detailDelegate = owner
                cell.selectedIndex = indexPath.row
                return cell
            }
        } else {
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoAddCollectionViewCell", for: indexPath) as! ToDoAddCollectionViewCell
            cell.delegate = owner
            return cell
            
        }
    }
}

//MARK: - Set Gesture && Profile Image Actions

extension ToDoCreateViewModel {
    internal func openAlert(owner: ToDoCreateViewController) {
        
        let alert: UIAlertController = UIAlertController(title: "Chose which way do you prefer", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openCamera(owner: owner)
        }
        
        let galleryAction = UIAlertAction(title: "Galery", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.openGallery(owner: owner)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        owner.imagePicker?.delegate = owner
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        let groundView = UIApplication.getPresentedViewController()!.view
        
        alert.popoverPresentationController?.sourceView = groundView!
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: groundView!.bounds.midX, y: groundView!.bounds.midY, width: 0, height: 0)
        UIApplication.getPresentedViewController()!.present(alert, animated: true)
        
    }
    
    private func openCamera(owner: ToDoCreateViewController) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            owner.imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            owner.imagePicker!.allowsEditing = false
            owner.present(owner.imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "OOPS", message: "Unknow Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            owner.present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery(owner: ToDoCreateViewController) {
        owner.imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        owner.imagePicker!.allowsEditing = true
        owner.present(owner.imagePicker!, animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


//MARK: - LocalPushNotification

extension ToDoCreateViewModel {
    
    func createNotfications(title: String, time: Double) {
        // CONTENT
        let content = UNMutableNotificationContent()
        content.title = "Did You Finish Your To Do Which is :"
        //        content.subtitle = "Bildirimin altbaşlığı"
        content.body = "\(title)"
        content.sound = UNNotificationSound.default // bildirimin sesi
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        // TRIGGER
        
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        let date = Date(timeIntervalSince1970: time)
        let triggerDate = Calendar.current.dateComponents([.year,.month, .day, .hour, .hour, .minute, .second], from: date)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //Create Category
        let category = UNNotificationCategory(identifier: "ToDoCategory", actions: [], intentIdentifiers: [], options: [])
        
        // Register Category
        center.setNotificationCategories([category])
        content.categoryIdentifier = "ToDoCategory"
        
        // REQUEST
        let identifier = title
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: dateTrigger)
        center.add(request) { (error) in
            if error != nil {
                print("Something wrong")
            }
        }
    }
    
}


