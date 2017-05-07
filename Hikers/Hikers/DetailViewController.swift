//
//  DetailViewController.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/06/03.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var Image: UIImageView!
    var passedShotImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Image.image = passedShotImage
    }

    @IBAction func returnBtn(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "main") as UIViewController
        let navigationController = UINavigationController(rootViewController: nextViewController)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
