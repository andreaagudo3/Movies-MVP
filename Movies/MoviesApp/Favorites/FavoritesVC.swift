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
    
    fileprivate let movieDetailPresenter = MovieDetailPresenter(movieDetailService: MovieDetailService())
    
    //fileprivate var dataToDisplay = Movie()
    
    let customCellId : String! = "customCellId"
    var ids: [Int] = []
    var idMovie: Int! = 0
    var favorites = [Favorite]()
    var favoritesKey = "favorites"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFavorites() {
        //loadFavorites
        if let decodedNSData = UserDefaults.standard.object(forKey: favoritesKey) as? Data {
            if let savedFavorites = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? [Favorite] {
                self.favorites = savedFavorites
            }
        }

    }
    
    func configureView() {
        //tableView
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: self.customCellId)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets.zero
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "movieDetailId") as! MovieDetailVC
        
        controller.idMovie = Int(favorites[indexPath.row].id)
        controller.isFavourite = true
        
        self.present(controller, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellId) as! CustomCell
        
        //cellView
        cell.titleMovie.text = favorites[indexPath.row].title
        
        //getImageUrl
        var properties: NSDictionary!
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
        }
        
        let fullUrl = (properties.object(forKey: "urlGetImage") as! String) + favorites[indexPath.row].image
        
        if let url = URL.init(string: fullUrl) {
            cell.imageMovie.downloadedFrom(url: url, contentMode: .scaleToFill)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
}

