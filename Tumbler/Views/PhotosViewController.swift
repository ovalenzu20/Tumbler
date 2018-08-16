//
//  PhotosViewController.swift
//  Tumbler
//
//  Created by Omar Valenzuela on 8/16/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource{

    var refreshControl : UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    var photos: [Photo] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        photoCell.photo = photo

        return photoCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = 200
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchPosts()
    }

    @objc func didPullToRefresh(_ refreshControl : UIRefreshControl){
        fetchPosts()
    }
    
    
    func fetchPosts(){
        TumblerApiManager().tumblerPhotoPosts{ (photos: [Photo]?, error: Error?) in
            if let photos = photos {
                self.photos = photos
                self.tableView.reloadData()
            }
        }
    }
    
}
