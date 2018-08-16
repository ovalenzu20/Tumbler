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
        
    }
}
