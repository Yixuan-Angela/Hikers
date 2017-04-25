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
        
        let demoPhotos = ["https://www.cabinsofthesmokymountains.com/things-to-do/wp-content/uploads/2015/02/hiking.jpg", "https://visit-brainerd.s3.amazonaws.com/gallery/787/walking_little_ben_arb_trail_in_the_fall_by_peg_serani_(3)__hd.jpg"]
        let demoNames = ["Appalaichia trail", "Central park trail", "Local trail"]
        
        var counter = 0
        
        for item in actualItems{
            var article: articleLink? = articleLink()
            article?.address = (item as! NSDictionary).value(forKeyPath: "data.url") as? String
            article?.address = "dummy data"
            article?.title = (item as! NSDictionary).value(forKeyPath: "data.title") as? String
            let nameIndex = counter % demoNames.count
            var name = demoNames[nameIndex]
            article?.title = name.appending(" \(counter + 1)")
            article?.thumb = (item as! NSDictionary).value(forKeyPath: "data.thumbnail") as? String
            let randomIndex = Int(arc4random_uniform(UInt32(demoPhotos.count)))
            let progressiveIndex = counter % demoPhotos.count
            article?.thumb = demoPhotos[progressiveIndex]
            article?.over18 = (item as! NSDictionary).value(forKeyPath: "data.over_18") as? Bool
            article?.over18 = true
            results?.append(article!)
            counter += 1
        }
        print(results)
        return results!
    }

}
