//
//  NewsViewModel.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import Foundation
import AlamofireImage

class NewsViewModel {
    private var articles : [Article] = [Article]()
    private let apiDFObj : ApiDataFetcher
    
    init() {
        self.apiDFObj = ApiDataFetcher()
    }
    
    func fetchArticles(completion: @escaping (Bool) -> Void) -> Void {
        apiDFObj.fetchApiData(){ res in
            guard let resArticles = res else {
                completion(false)
                return
            }
            self.articles.append(contentsOf: resArticles)
            completion(true)
            return
        }
    }
    
    func getArticles() -> [Article] {
        return self.articles
    }
    
    func fetchImage(withUrlStr url : String, completion: @escaping (Image?) -> Void) -> Void {
        apiDFObj.fetchImg(withUrlStr: url){ img in
            guard let img = img else {
                completion(nil)
                return
            }
            completion(img)
        }
    }
    
    func getArticleCount() -> Int {
        return self.articles.count
    }
    
}
