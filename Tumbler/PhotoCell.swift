//
//  PhotoCell.swift
//  Tumbler
//
//  Created by Omar Valenzuela on 8/16/18.
//  Copyright © 2018 Omar Valenzuela. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    var photo : Photo!
    
    func setupViews(){
        photoImageView.af_setImage(withURL: photo.url)
    }

}
