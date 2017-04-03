//
//  redditNetworking.swift
//  We The People
//
//  Created by Rafi Rizwan on 2/24/17.
//  Copyright © 2017 vi66r. All rights reserved.
//

import UIKit
import Alamofire

class redditNetworking: NSObject {

    var links: [String]? = nil
    
    func getNewsFromReddit(completionClosure:@escaping (_ links: [articleLink])->()){
        let URL = "http://reddit.com/r/uspolitics/hot.json?limit=100"
    
        
        Alamofire.request(URL).responseJSON{ response in
            let things = linksBuilder().buildObjectsFromJSON(data: response.result.value as! NSDictionary)
            print(response)
            print(things.count)
            completionClosure(things)
        }
        
    }
}
