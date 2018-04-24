//
//  DetailMovie.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDetail: NSObject, Mappable{
    
    var frontImage : String! = ""
    var bkImage: String! = ""
    var overview : String! = ""
    var title: String! = ""
    
    func mapping(map: Map) {
        bkImage <- map["backdrop_path"]
        frontImage <- map["poster_path"]
        overview <- map["overview"]
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
