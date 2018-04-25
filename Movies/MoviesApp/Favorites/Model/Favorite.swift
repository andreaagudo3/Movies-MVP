//
//  Favorite.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation

class Favorite: NSObject{
    var id: String!
    var title: String!
    var image: String!
    
    
    init(id: String, title:String, image: String) {
        self.id = id
        self.title = title
        self.image = image
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! String
        self.init(id: id, title: title, image: image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(image, forKey: "image")
    }
    
}
