//
//  linksBuilder.swift
//  We The People
//
//  Created by Rafi Rizwan on 2/25/17.
//  Copyright © 2017 vi66r. All rights reserved.
//

import UIKit

class linksBuilder: NSObject {
    func buildObjectsFromJSON(data: NSDictionary) -> [articleLink]{
        var results: [articleLink]? = [articleLink]()
        
        let items = data.value(forKeyPath: "data.children") as! NSArray
        var actualItems = NSMutableArray(array: items)
        actualItems.removeObject(at: 0)
//        print(actualItems)
        
        for item in actualItems{
            var article: articleLink? = articleLink()
            article?.address = (item as! NSDictionary).value(forKeyPath: "data.url") as? String
            article?.address = "dummy data"
            article?.title = (item as! NSDictionary).value(forKeyPath: "data.title") as? String
            article?.title = "This is a trail name"
            article?.thumb = (item as! NSDictionary).value(forKeyPath: "data.thumbnail") as? String
            article?.thumb = "https://www.fs.usda.gov/Internet/FSE_MEDIA/stelprdb5189258.jpg"
            article?.over18 = (item as! NSDictionary).value(forKeyPath: "data.over_18") as? Bool
            article?.over18 = true
            results?.append(article!)
        }
        print(results)
        return results!
    }

}
