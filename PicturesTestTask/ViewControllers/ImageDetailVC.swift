//
//  ImageDetailVC.swift
//  PicturesTestTask
//
//  Created by OMac on 8/21/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import PicturesNetwork

class ImageDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var pictureModel: PictureModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        // Do any additional setup after loading the view.
    }
    
    func getImage() {
        if let model = pictureModel {
            PicturesNetworkManager.getImageFrom(model.urls?.full ?? "") { (image) in
                self.imageView.image = image
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
