//
//  DetailsTableViewCell.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/9/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
