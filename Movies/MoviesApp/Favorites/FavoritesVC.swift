//
//  FavoritesVC.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let moviesPresenter = MoviesPresenter(moviesService: MoviesService())
    fileprivate let movieDetailPresenter = MovieDetailPresenter(movieDetailService: MovieDetailService())
    
    fileprivate var dataToDisplay = Movie()
    
    let customCellId : String! = "customCellId"
    var ids: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getFavorites()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFavorites() {
        
        let userdefaults = UserDefaults.standard
        
        let dataObject: [Favorite] = ["title": dataToDisplay.title, "image" : dataToDisplay.bkImage, "id": String(idMovie)]
        
        let favoritesArray : NSArray = userdefaults.object(forKey: "favorites") as! NSArray

    }
    
    func configureView() {
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

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
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

extension FavoritesVC: MoviesView {
    
}
