//
//  VideoCollectionViewCell.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 13/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videotitleLabel: UILabel!
    @IBOutlet weak var playbuttonImageView: UIImageView!
    
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
    }
    
}
