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
    var posts: [[String : Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        let photosDictionary = post["photos"] as! [[String : Any]]
        let photoDictionary = photosDictionary[0]
        let photo = Photo(dictionary: photoDictionary)
        photoCell.photo = photo
        photoCell.setupViews()
        
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
        TumblerApiManager().tumblerPhotoPosts{ (posts: [[String : Any]]?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Cannot get posts", message: "The internet connection appears to be off", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try Again", style: .default) { (action) in
                    self.fetchPosts()
                }
                
                alertController.addAction(tryAgain)
                self.present(alertController, animated: true)
            }
            else if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
    }
    
}
