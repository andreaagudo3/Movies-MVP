//
//  ImageService.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Alamofire
import ObjectMapper

class ImageService : NSObject {
    
    var properties: NSDictionary!
    
    // MARK: - getImage
    
    func getImage(parameters : [String: String],completion: @escaping (_ response: AnyObject?) -> ()){
        
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
        }
        
        var parameter2 : [String: String]? = ["maxRows": "20" as String , "startRow" : "0" as String, "lang" : "en" as String, "isNameRequired" : "true" as String, "username" : "ilgeonamessample" as String, "style": "FULL" as String]
        
        
        parameter2?.merge(dict: parameters)
        print("Parametros: " + String(describing: parameter2))
        
        Alamofire
            .request(properties.object(forKey: "urlLocation") as! String, method: .post, parameters: parameter2, encoding: URLEncoding.default, headers: nil)
            .responseJSON{response in
                switch response.result{
                case .success(let value):
                    completion(value as AnyObject)
                    
                    //print(response)
                    
                    
                case .failure(let error):
                    completion(error as AnyObject)
                    print("Algo ha ido mal")
                }
                
        }
        
    }
    
    func getMoviesMapped(completion:@escaping (_ response: () throws ->  Movie?) -> Void){
        
        getMovies(completion: { (response) in
            let result = response as? [String: AnyObject]
            
            if(result?["results"] != nil){
                let map = Map.init(mappingType: MappingType.fromJSON, JSON: result!)
                let resultMovies = Movie(map: map)
                
                completion({return resultMovies})
            }
            else{
                completion({return nil})
            }
            
        })
    }
}

