//
//  ImageAddProtocol.swift
//  Cargram
//
//  Created by Batuhan Ketahte 28.11.2020
//  Copyright © 2020 Batuhan Ketahte. All rights reserved.
//

protocol ImageAddProtocol {
    func imageProtocolAdd()
}

protocol ImageRemoveProtocol {
    func imageProtocolRemove(selectedCell: Int)
}

protocol ImageDetailShow {
    func imageProtocolShow(selectedCell: Int)
}
