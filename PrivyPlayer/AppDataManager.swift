//
//  AppDataManager.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 14/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class AppDataManager: NSObject {

    var VideoResponsefromHomeAPI = Array<Any>()
    var CategoryNameList = Array<String>()
    
    static let sharedInstance:AppDataManager = {
        let instance = AppDataManager ()
        return instance
    } ()
    
    override init() {
        super.init()
    }
}
