//
//  MoviesListVC.swift
//  Movies
//
//  Created by Andrea Agudo on 23/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import UIKit

class MoviesListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let moviesPresenter = MoviesPresenter(moviesService: MoviesService())
    fileprivate var dataToDisplay = Movie()
    
    let cellId : String! = "movieCellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callService()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callService() {
        self.moviesPresenter.getMovies()
    }
    
    func configureView() {
        //tableView
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        //presenter
        moviesPresenter.attachView(self)
    }
}

extension MoviesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MovieCell
        
        movieCell.titleMovie.text = self.dataToDisplay.results[indexPath.row].title
    
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataToDisplay.results.count
    }
}

extension MoviesListVC: MoviesView {
    func moviesDataRecieved() {
        
    }
    
    func error() {
        
    }
    
    func setData(_ data: Movie) {
        dataToDisplay = data
        print("DataToDisplay: " + String(describing: dataToDisplay))
    }
}
