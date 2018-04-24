//
//  MovieDetailService.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Alamofire
import ObjectMapper

class MovieDetailService : NSObject {
    
    var properties: NSDictionary!
    
    // MARK: - getMovies
    
    func getMovieDetail(id: Int, completion: @escaping (_ response: AnyObject?) -> ()){
        
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
        }
        
        let apiKey = properties.object(forKey: "api_key") as! String
        
        Alamofire
            .request(properties.object(forKey: "urlGetDetail") as! String + String(id) + "?api_key=" + apiKey , method: .get, encoding: URLEncoding.default, headers: nil)
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
    
    func getMovieDetailMapped(id: Int, completion:@escaping (_ response: () throws ->  MovieDetail?) -> Void){
        
        getMovieDetail(id: id, completion: { (response) in
            let result = response as? [String: AnyObject]
            
            if(result?["overview"] != nil){
                let map = Map.init(mappingType: MappingType.fromJSON, JSON: result!)
                let resultDetailMovie = MovieDetail(map: map)
                
                completion({return resultDetailMovie})
            }
            else{
                completion({return nil})
            }
            
        })
    }
}

