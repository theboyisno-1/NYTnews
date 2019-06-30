//
//  News.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import Foundation


struct Multimedia: Codable {
    let url: String?
    let type: String?
}

struct Article : Codable {
    let title: String?
    let abstract: String?
    let url: String?
    let byline: String?
    let multimedia: [Multimedia]?
}

struct News: Codable {
    let status: String?
    let numOfArticles: Int?
    let articles: [Article]?
    
    private enum CodingKeys: String, CodingKey{
        case status
        case numOfArticles = "num_results"
        case articles =  "results"
    }
}
