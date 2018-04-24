//
//  Movie.swift
//  Movies
//
//  Created by Andrea Agudo on 23/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: NSObject, Mappable{
    
    var results = [Results]()
    
    func mapping(map: Map) {
        results <- map["results"]
    }
    
    required init?(map: Map){
        super.init()
        self.mapping(map: map)
    }
    
    override init() {
        super.init()
    }
    
}


class Results: NSObject, Mappable{
    var id = ""
    var poster = ""
    var title = ""
    
    func mapping(map: Map) {
        
        id <- map["id"]
        poster <- map["backdrop_path"]
        title <- map["original_title"]
    }
    
    required init?(map: Map){
        super.init()
        self.mapping(map: map)
    }
    
    override init() {
        super.init()
    }
    
}
