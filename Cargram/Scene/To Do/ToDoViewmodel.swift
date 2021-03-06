//
//  ToDoViewmodel.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit
import RealmSwift

final class ToDoViewModel {

    lazy var todoArray: [ToDoRealmModel] = []
    
    func setSelectedRow(indexPath: Int) -> ToDoDetailViewController {
        let vc = ToDoDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.toDoDetailViewModel.toDoSelectedArray = todoArray[indexPath]
        vc.toDoDetailViewModel.selectedIndex = indexPath
        return vc
    }
    
    func numberOfRows() -> Int{
        if todoArray.count == 0 {
            return 1
        } else {
            return todoArray.count
        }
    }
    
    func fetchData(completion: @escaping(Bool) -> Void) {
        let realm = try! Realm()
        let res = realm.objects(ToDoRealmModel.self)
        todoArray.removeAll()
        for data in res {
            print(data)
            self.todoArray.append(data)
        }
        completion(true)
    }
    
    func setCollectionViewCell(owner: ToDoViewController, indexPath: IndexPath) -> UICollectionViewCell {
        
        switch todoArray.count {
        case 0:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoNonCollectionViewCell", for: indexPath) as! ToDoNonCollectionViewCell
            return cell
        default:
            let cell = owner.collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionViewCell", for: indexPath) as! ToDoCollectionViewCell
            let selected = todoArray[indexPath.row]
            if selected.picArray.count != 0 {
                cell.image.image = UIImage(data: selected.picArray[0])
            } else {
                cell.backgroundColor = .gray
            }
            cell.isCompletedImage.isHidden = !(selected.toDoCompletted)
            cell.title.text = selected.toDoTitle
            cell.subTitle.text = selected.toDoDescription
            if selected.toDoDateShow {
                cell.endTime = selected.deathline
            }
            return cell
        }
    }
}

