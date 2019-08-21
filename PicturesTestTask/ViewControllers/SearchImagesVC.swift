//
//  SearchImagesVC.swift
//  PicturesTestTask
//
//  Created by OMac on 8/22/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import PicturesNetwork

class SearchImagesVC: UIViewController {

    @IBOutlet weak var tableViewBottom: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var pictures = Pictures()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unobserveKeyboard()
    }
    
    func settings() {
        registerNibs()
        configureSearchController()
        observeKeyboard()
    }
    
    override func keyboardConstraint() -> NSLayoutConstraint? {
        return tableViewBottom
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Images"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func registerNibs() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TableImageCell")
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

extension SearchImagesVC: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableImageCell", for: indexPath) as! TableViewCell
        let model = pictures[indexPath.row]
        if let url = model.urls?.regular {
            cell.configureWith(url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = pictures[indexPath.row]
        self.performSegue(withIdentifier: "showImageDetailVC", sender: model)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.pictures.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    

}


extension SearchImagesVC: UISearchResultsUpdating {
    // MARK: - Search
    
    private func getData(query: String? = nil) {
        PicturesNetworkManager.getPictures(query: query, completion: { result in
            do {
                let data = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                if let pics = searchResponse.results {
                    self.pictures = pics
                    self.tableView.reloadData()
                }
            } catch (let error) {
                print(error)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text?.count ?? 0) > 3 {
            getData(query: searchController.searchBar.text!)
        }
    }
}
