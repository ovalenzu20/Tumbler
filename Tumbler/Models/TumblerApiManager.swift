//
//  TumblerApiManager.swift
//  Tumbler
//
//  Created by Omar Valenzuela on 8/16/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import Foundation

class TumblerApiManager{
    
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    func tumblerPhotoPosts(completion: @escaping ([Photo]?, Error?) -> ()){
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                let postsDictionary = responseDictionary["posts"] as! [[String : Any]]
                let photos = Photo.photos(dictionaries: postsDictionary)
                
                completion(photos, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
