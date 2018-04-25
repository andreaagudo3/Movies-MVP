//
//  DetailMovieVC.swift
//  Movies
//
//  Created by Andrea Agudo on 24/4/18.
//  Copyright © 2018 Andrea Agudo. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bkImage: UIImageView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    var isFavourite = false
    
    fileprivate let movieDetailPresenter = MovieDetailPresenter(movieDetailService: MovieDetailService())
    fileprivate var dataToDisplay = MovieDetail()
    
    @IBOutlet weak var closeBtn: UIButton!
    var idMovie: Int! = 0
    let favoritesKey: String! = "favorites"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func configureView() {
        //button
        let image = UIImage(named: "cross")
        closeBtn.setImage(image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: [])
        closeBtn.tintColor = UIColor.white
        
        //presenter
        movieDetailPresenter.attachView(self)
        
        //image
        bkImage.addBlur()
        frontImage.layer.borderWidth = 2
        frontImage.layer.borderColor = UIColor.white.cgColor
        
        //favoriteBtn
        if self.isFavourite == true {
            self.favoriteBtn.setImage(UIImage(named: "fullStar"), for: .normal)
        }else{
            self.favoriteBtn.setImage(UIImage(named: "emptyStar"), for: .normal)
        }
        
    }
    
    func callService() {
        self.movieDetailPresenter.getMovieDetail(id:idMovie)
    
    }
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        
        
        let favoriteDataToSave: Favorite = Favorite(id: String(idMovie), title: dataToDisplay.title, image : dataToDisplay.bkImage)
        var favorites = [Favorite]()
        
        //loadFavorites
        if let decodedNSData = UserDefaults.standard.object(forKey: favoritesKey) as? Data {
            if let savedFavorites = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData as Data) as? [Favorite] {
                favorites = savedFavorites
            }
        }
        
        if self.isFavourite == true{
            self.isFavourite = false
            favoriteBtn.setImage(UIImage(named: "emptyStar"), for: .normal)
            
            //removeFavorite
            var index: Int! = 0
            for fav in favorites {
                if fav.id == String(idMovie){
                    favorites.remove(at: index)
                }
                index = index + 1
            }
            
            //setFavorites
            let archivedObject = NSKeyedArchiver.archivedData(withRootObject: favorites)
            let defaults = UserDefaults.standard
            defaults.set(archivedObject, forKey: favoritesKey)
            defaults.synchronize()
            
            
        }else{
            self.isFavourite = true
            
            var isRepeat: Bool! = false
            
            //checkRepeatFavorite
            var index: Int! = 0
            for fav in favorites {
                if fav.id == String(idMovie){
                    isRepeat = true
                }
                index = index + 1
            }
            
            //addNewFavorite
            
            if isRepeat == false{
                favorites.append(favoriteDataToSave)
                //rememberFavorite
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: favorites)
                let defaults = UserDefaults.standard
                defaults.set(archivedObject, forKey: favoritesKey)
                defaults.synchronize()
            }
            
            favoriteBtn.setImage(UIImage(named: "fullStar"), for: .normal)
        }
    }
    
}


extension MovieDetailVC: MovieDetailView {
    func movieDetailDataRecieved() {
        
    }
    
    func setData(_ data: MovieDetail) {
        dataToDisplay = data
        
        //images
        var properties: NSDictionary!
        
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist") {
            properties = NSDictionary(contentsOfFile: path)
        }
        
        let fullUrlFront = (properties.object(forKey: "urlGetImage") as! String) + dataToDisplay.frontImage
        
        let fullUrlBk = (properties.object(forKey: "urlGetImage") as! String) + dataToDisplay.bkImage
        
        if let url = URL.init(string: fullUrlFront) {
            frontImage.downloadedFrom(url: url, contentMode: .scaleToFill)
        }
        
        if let url = URL.init(string: fullUrlBk) {
            bkImage.downloadedFrom(url: url, contentMode: .scaleAspectFill)
        }
        
        //labels
        descriptionLabel.text = dataToDisplay.overview
        titleLabel.text = dataToDisplay.title
        
        print("DataToDisplayDetail: " + String(describing: dataToDisplay))
    }
    
    func error() {
        
    }
    
    
}
