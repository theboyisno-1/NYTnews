//
//  ApiDataFetcher.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ApiDataFetcher {

    private let endPointStr : String = Endpoint().getUrl()
    
    
    /// This is base fucntion for all networking. Helpful for retrieving images
    ///
    /// - Parameters:
    ///   - url: String url to fetch data from
    ///   - completion: handler
    func fetchImg(withUrlStr url : String, completion: @escaping (Image?) -> Void) -> Void {
        Alamofire.request(url).responseImage(completionHandler: { response in
            guard let image = response.result.value else {
                completion(nil)
                return
            }
            completion(image)
        })
    }
    
    
    /// Fetch data from api endpoint
    ///
    /// - Parameter completion: completion handler
    func fetchApiData(completion: @escaping ([Article]?) -> Void) -> Void {
        var articles = [Article]()
        Alamofire.request(self.endPointStr).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                guard let art = news.articles else {
                    completion(nil)
                    return
                }
                articles.append(contentsOf: art)
                completion(articles)
            } catch {
                completion(nil)
            }
        }
    }
}
