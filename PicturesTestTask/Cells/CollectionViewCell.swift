//
//  CollectionViewCell.swift
//  PicturesTestTask
//
//  Created by OMac on 8/21/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import PicturesNetwork

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ imageUrl: String) {
        self.imageView.image = nil
        PicturesNetworkManager.getImageFrom(imageUrl) { (image) in
            self.imageView.image = image
        }
    }

}
