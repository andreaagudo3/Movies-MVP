//
//  Favorite.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation

class Favorite: NSObject, NSCoding{
    var id: String!
    var title: String!
    var image: String!
    
    
    init(id: String, title:String, image: String) {
        self.id = id
        self.title = title
        self.image = image
        
    }
    
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObject(forKey: "title") as? String else { return nil }
        guard let id = decoder.decodeObject(forKey: "id") as? String else { return nil }
        guard let image = decoder.decodeObject(forKey: "image") as? String else { return nil }
        
        self.init(id: id, title: title, image: image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.image, forKey: "image")
    }
    
}
