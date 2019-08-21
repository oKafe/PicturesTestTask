//
//  ViewController.swift
//  PicturesTestTask
//
//  Created by OMac on 8/21/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import PicturesNetwork

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pictures = Pictures()
    var currentPage = 1
    var isUpdating = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        settings()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func settings() {
        self.title = "Images"
        registerNibs()
    }
    
    private func registerNibs() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "imageCell")
    }
    
    //MARK: - Get data methods
    
    private func getData() {
        isUpdating = true
        PicturesNetworkManager.getPictures(page: currentPage, completion: { result in
            do {
                let data = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                let pictures = try JSONDecoder().decode(Pictures.self, from: data)
                for pic in pictures {
                    self.pictures.append(pic)
                    let indexPath = IndexPath(row: self.pictures.count - 1, section: 0)
                    self.collectionView.insertItems(at: [indexPath])
                }
                self.currentPage += 1
            } catch (let error) {
                print(error)
            }
            self.isUpdating = false
        }) { (error) in
            self.isUpdating = false
            print(error)
        }
    }
    //MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageDetail = segue.destination as? ImageDetailVC {
            if let model = sender as? PictureModel {
                imageDetail.pictureModel = model
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        let model = pictures[indexPath.item]
        let url = model.urls?.small ?? ""
        cell.configureWith(url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let sideSize = screenWidth/3 - 3
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = pictures[indexPath.item]
        self.performSegue(withIdentifier: "showImageDetailVC", sender: model)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
            if !isUpdating {
                if currentPage <= 10 {
                    getData()
                }
            }
        }
    }
}

