//
//  MovieModel.swift
//  Marsplay Assignment
//
//  Created by Raghav Sethi on 30/11/19.
//  Copyright © 2019 Raghav Sethi. All rights reserved.
//

import Foundation

class Movie: Codable    {
    
    var title: String
    var year: String
    var poster: String
    var type: String
    
    init(title: String, year: String, poster: String, type: String) {
        self.title = title
        self.year = year
        self.poster = poster
        self.type = type
    }
    
    init() {
        self.title = ""
        self.year = ""
        self.poster = ""
        self.type = ""
    }
    
    func validMovie() -> Bool    {
        return self.title.count > 0
    }
    
    func validYear() -> Bool    {
        let a = Int(String(self.year.prefix(4)))
        if a! > 1000 && a! < 2050 {
            return true
        }   else    {
            return false
        }
    }
    
}
