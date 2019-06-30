//
//  Endpoint.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import Foundation


struct Endpoint {
    private let url : String = "https://api.nytimes.com/svc/topstories/v2/technology.json?api-key=SLuQoGMFhmfDjjkwwH4lnJbvXS6fPlis"
    
    func getUrl() -> String {
        return url
    }
}
