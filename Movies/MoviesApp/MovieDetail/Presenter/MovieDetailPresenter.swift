//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation

protocol MovieDetailView {
    func movieDetailDataRecieved()
    func setData(_ data: MovieDetail)
    func error()
}

class MovieDetailPresenter {
    
    let movieDetailService: MovieDetailService
    var movieDetailView : MovieDetailView?
    
    init(movieDetailService: MovieDetailService){
        self.movieDetailService = movieDetailService
    }
    
    func attachView(_ view: MovieDetailView){
        movieDetailView = view
    }
    
    func detachView() {
        movieDetailView = nil
    }
    
    //MARK: - Get Movies
    
    func getMovieDetail(id: Int){
        movieDetailService.getMovieDetailMapped(id: id){ response in
            self.checkMovieDetail(data: response)
        }
        
    }
    
    func checkMovieDetail(data: () throws -> MovieDetail?){
        do{
            let result = try data()
            if ( result != nil) {
                let movieDetailResult = result!
                
                    let mappedData = movieDetailResult
                    
                    self.movieDetailView?.setData(mappedData)
                    
                    print(String(describing: mappedData))
                
                
                self.movieDetailView?.movieDetailDataRecieved()
                
            }else{
                self.movieDetailView?.error()
            }
            
        }catch _{
            print("Se ha producido un error")
        }
    }
}

