//
//  UserAgreementViewController.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

import UIKit
import SnapKit

class UserAgreementViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+40000)
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        return scroll
    }()
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Agreements"
        setUI()
    }
}

//MARK: - Setup UI

extension UserAgreementViewController {
    
    func setUI() {
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.contentSize = contentViewSize
        label.numberOfLines = 0
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        scrollView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.view.frame.width-10)
            make.centerX.equalToSuperview()
        }
        label.text = "End-User ail.com"
    }
}
