//
//  ViewController.swift
//  We The People
//
//  Created by Rafi Rizwan on 2/7/17.
//  Copyright © 2017 vi66r. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.white
        
        redditNetworking().getNewsFromReddit { (listings: [articleLink]) in
            print("operation complete")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

