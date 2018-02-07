//
//  MyHistoryTableViewCell.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 03/02/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit

class MyHistoryTableViewCell: UITableViewCell {
    @IBOutlet var HistoryImageView: UIImageView!
    @IBOutlet var HistoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        HistoryImageView.layer.cornerRadius = 5
//        HistoryImageView.layer.borderColor = UIColor.white.cgColor
//        HistoryImageView.layer.borderWidth = 1
        HistoryImageView.layer.masksToBounds = true
    }

}
