//
//  DetailViewController.swift
//  Marsplay Assignment
//
//  Created by Raghav Sethi on 01/12/19.
//  Copyright © 2019 Raghav Sethi. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var movie = Movie()
    
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
    }
    
    func setupMovie()   {
        self.year.text = "Released in: \(movie.year)"
        self.movieTitle.text = movie.title
        self.type.text = movie.type
        self.image.sd_setImage(with: URL(string: movie.poster), placeholderImage: .none, options: .continueInBackground, completed: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
