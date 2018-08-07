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
    fileprivate let movieDetailPresenter = MovieDetailPresenter(movieDetailService: MovieDetailService())
    
    fileprivate var dataToDisplay = Movie()
    
    let customCellId = "customCellId"
    var ids = [Int]()
    
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
    
    private func callService() {
        self.moviesPresenter.getMovies()
    }
    
    private func configureView() {
        //tableView
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: self.customCellId)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets.zero
        
        tableView.delegate = self
        tableView.dataSource = self
   
        //presenter
        moviesPresenter.attachView(self)
    }
    

}

extension MoviesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "movieDetailId") as! MovieDetailVC
        
        controller.idMovie = ids[indexPath.row]
        
        self.present(controller, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellId) as! CustomCell
        
        //cellView
        cell.titleMovie.text = dataToDisplay.results[indexPath.row].title
        
        //getImageUrl
        var properties: NSDictionary!
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
        }
        
        let fullUrl = (properties.object(forKey: "urlGetImage") as! String) + dataToDisplay.results[indexPath.row].poster
        
        if let url = URL.init(string: fullUrl) {
            cell.imageMovie.downloadedFrom(url: url, contentMode: .scaleToFill)
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataToDisplay.results.count
    }
}

extension MoviesListVC: MoviesView {
  
    func moviesDataRecieved() {
        tableView.reloadData()
    }
    
    func error() {
        
    }
    
    func setData(_ data: Movie) {
        dataToDisplay = data
        
        for movie in self.dataToDisplay.results {
            self.ids.append(movie.id)
        }
    
        print("DataToDisplay: " + String(describing: dataToDisplay))
    }
}
