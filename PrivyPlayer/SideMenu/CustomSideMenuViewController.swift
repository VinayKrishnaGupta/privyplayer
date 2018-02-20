//
//  CustomSideMenuViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SideMenuController

class CustomSideMenuViewController: SideMenuController {
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .underCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 250
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .fadeAnimation
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
        
        super.init(coder: aDecoder)
    }
    
   
    
    // MARK: - SINCallClientDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "embedInitialCenterController", sender: nil)
        performSegue(withIdentifier: "embedSideController", sender: nil)
      //  self.client.delegate = self as! SINClientDelegate
        
        
        // Do any additional setup after loading the view.
}
}
