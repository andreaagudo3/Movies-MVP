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
    
    fileprivate let movieDetailPresenter = MovieDetailPresenter(movieDetailService: MovieDetailService())
    fileprivate var dataToDisplay = MovieDetail()
    
    @IBOutlet weak var closeBtn: UIButton!
    var idMovie: Int! = 0

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
        
    }
    
    func callService() {
        self.movieDetailPresenter.getMovieDetail(id:idMovie)
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