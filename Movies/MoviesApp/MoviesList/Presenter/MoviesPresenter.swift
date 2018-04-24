//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Andrea Agudo on 23/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import Foundation

protocol MoviesView {
    func moviesDataRecieved()
    func setData(_ data: Movie)
    func error()
}

class MoviesPresenter {
    
    let moviesService: MoviesService
    var moviesView : MoviesView?
    
    
    init(moviesService: MoviesService){
        self.moviesService = moviesService
    }
    
    func attachView(_ view: MoviesView){
        moviesView = view
    }
    
    func detachView() {
        moviesView = nil
    }
    
    //MARK: - Get Movies
    
    func getMovies(){
        moviesService.getMoviesMapped() { response in
            self.checkMovies(data: response)
        }
        
    }
    
    func checkMovies(data: () throws -> Movie?){
        do{
            let result = try data()
            if ( result != nil) {
              let moviesResult = result!

                if moviesResult.results.count > 0 {
                    let mappedData = moviesResult
                    
                    self.moviesView?.setData(mappedData)
                    
                    print(String(describing: mappedData))
                }
                
                    self.moviesView?.moviesDataRecieved()
                    
                }else{
                    self.moviesView?.error()
                }
            
        }catch _{
            print("Se ha producido un error")
        }
    }
}
