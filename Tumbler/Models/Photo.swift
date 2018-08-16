//
//  Photo.swift
//  Tumbler
//
//  Created by Omar Valenzuela on 8/16/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import Foundation

class Photo{
    var url : URL
    
    
    init(dictionary: [String: Any]){
        let originalSize = dictionary["original_size"] as! [String : Any]
        let urlAsString = originalSize["url"] as! String
        self.url = URL(string: urlAsString)!
        
    }
    
    func photos(dictionaries : [[String: Any]]) -> [Photo]{
        var photos : [Photo] = []
        for dictionary in dictionaries{
            let photo = Photo(dictionary: dictionary)
            photos.append(photo)
        }
        return photos
    }
}
