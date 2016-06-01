//
//  TableViewCell.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/2/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class MyRestarauntsTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var isVisitedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
