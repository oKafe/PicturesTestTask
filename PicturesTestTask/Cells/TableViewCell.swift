//
//  TableViewCell.swift
//  PicturesTestTask
//
//  Created by OMac on 8/22/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import PicturesNetwork

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bigImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(_ imageUrl: String) {
        self.bigImageView.image = nil
        PicturesNetworkManager.getImageFrom(imageUrl) { (image) in
            self.bigImageView.image = image
        }
    }
    
}
