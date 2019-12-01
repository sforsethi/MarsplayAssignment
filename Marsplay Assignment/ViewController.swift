//
//  ViewController.swift
//  Marsplay Assignment
//
//  Created by Raghav Sethi on 30/11/19.
//  Copyright © 2019 Raghav Sethi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    var movies = [Movie]()
    let movie_URL = "http://www.omdbapi.com/"
    var year = 0
    var loadMore = false
    var pageNo = 1
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDate()
        getMovieData(pageNo: 1)
    }
    
    func setupDate()    {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        self.year = Int(formattedDate)!
    }
    
    func getMovieData(pageNo: Int) {
        let parameters = ["s": "Batman","page": "\(pageNo)","apikey": "eeefc96f"]
        Alamofire.request(movie_URL, method: .get, parameters:parameters ).responseJSON(completionHandler: { (response) in
            if response.result.isSuccess    {
                print("Request Successful!")
                let movieJSON: JSON = JSON(response.result.value!)
                self.updateMovieData(json: movieJSON)
            }   else    {
                
            }
        })
    }
    
    func updateMovieData(json: JSON)    {
        
        let n = json["Search"].count
        print(n)
        loadMore = json["Response"].boolValue
        var i = 0
        while i<n {
            let title = json["Search"][i]["Title"].stringValue
            let tempYear = json["Search"][i]["Year"].stringValue
            let year = String(tempYear.prefix(4))
            let type = json["Search"][i]["Type"].stringValue
            let poster = json["Search"][i]["Poster"].stringValue
            
            let movie = Movie(title: title, year: year, poster: poster, type: type)
            
            movies.append(movie)
            i += 1
        }
        self.collectionView.reloadData()
    }
     public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
           if UIDevice.current.orientation.isLandscape,
            let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let width = view.frame.width*0.4
            let height = view.frame.height*0.2
               layout.itemSize = CGSize(width: width, height: height)
               layout.invalidateLayout()
           } else if UIDevice.current.orientation.isPortrait,
            let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let width = view.frame.width*0.48
            let height = view.frame.height*0.3
               layout.itemSize = CGSize(width: width, height: height)
               layout.invalidateLayout()
           }
       }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width*0.43

        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.title.text = movies[indexPath.row].title
        print(movies[indexPath.row].title)
        if movies[indexPath.row].year != ""    {
            print("\(movies[indexPath.row].title) : \(movies[indexPath.row].year)")
            if year - (Int(movies[indexPath.row].year)!) > 1 {
        cell.year.text = "\(self.year - (Int(movies[indexPath.row].year) ?? 0)) years ago"
            }   else    {
        cell.year.text = "\(self.year - (Int(movies[indexPath.row].year) ?? 0)) year ago"
            }
        }
        cell.image.sd_setImage(with: URL(string: movies[indexPath.row].poster), placeholderImage: .none, options: .continueInBackground, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        next.movie = self.movies[indexPath.row]
        self.present(next, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count-3  {
            updateNextSet()
        }
    }
    
    func updateNextSet()    {
        if self.loadMore == true    {
            pageNo += 1
            print("Page no: \(pageNo)")
            getMovieData(pageNo: pageNo)
        }
    }
    
}
