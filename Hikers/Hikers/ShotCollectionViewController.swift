//
//  ShotCollectionViewController.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/05/22.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit
import SDWebImage

let reuseIdentifier_Shot = "ShotCollectionViewCell"

class ShotCollectionViewController: UICollectionViewController, UISearchBarDelegate{
    fileprivate var shots:[articleLink] = [articleLink]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    private var filteredShots:[articleLink] = [articleLink]()
    
    private var isSearching = false
    
    fileprivate var cellWidth:CGFloat = 0.0
    fileprivate var cellHeight:CGFloat = 0.0
    
    fileprivate let cellVerticalMargin:CGFloat = 20.0
    fileprivate let cellHorizontalMargin:CGFloat = 20.0
    
    private var mySearchBar: UISearchBar!
    private var myLabel : UILabel!
    
    var API_URL = Config.SHOT_URL

    
    var shotPages = 1
    
    override func viewDidLoad() {
        
        
        // make UISearchBar instance
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.frame.width, height: 80))
        mySearchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 0)
        
//        // add shadow
//        mySearchBar.layer.shadowColor = UIColor.black.cgColor
//        mySearchBar.layer.shadowOpacity = 0.5
//        mySearchBar.layer.masksToBounds = false
        
        // hide cancel button
        mySearchBar.showsCancelButton = true
        
        // hide bookmark button
        mySearchBar.showsBookmarkButton = false
        
        // set Default bar status.
        mySearchBar.searchBarStyle = UISearchBarStyle.default
        
        // set title
        mySearchBar.prompt = "Title"
        
        // set placeholder
        mySearchBar.placeholder = "Search for a trail!"
        
        // change the color of cursol and cancel button.
        mySearchBar.tintColor = UIColor.white
        
        // hide the search result.
        mySearchBar.showsSearchResultsButton = false
        
        // add searchBar to the view.
        self.view.addSubview(mySearchBar)
        
//        // make UITextField
//        myLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 200, height: 30)))
//        myLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
//        myLabel.text = ""
//        myLabel.layer.borderWidth = 1.0
//        myLabel.layer.borderColor = UIColor.gray.cgColor
//        myLabel.layer.cornerRadius = 10.0
////
////        // add the label to the view.
//        self.view.addSubview(myLabel)
//        self.navigationController?.navigationBar.addSubview(myLabel)
        
        
        super.viewDidLoad()
    }
    
    
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        myLabel.text = searchText
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        myLabel.text = ""
        mySearchBar.text = ""
        filteredShots.removeAll()
        isSearching = false
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        mySearchBar.text = "Search for a trail!"
        print("triggered")
        
        for places in self.shots{
            if places.title?.caseInsensitiveCompare(mySearchBar.text!) == .orderedSame{
                filteredShots.append(places)
            }
        }
        
        self.view.endEditing(true)
    }
    
    
    func loadShots(){
        self.collectionView!.backgroundColor = UIColor.hexStr("f5f5f5", alpha: 1.0)
        
        cellWidth = self.view.bounds.width / 2
        cellHeight = self.view.bounds.width / 2
        
        self.collectionView?.register(UINib(nibName: "ShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier_Shot)
        
        redditNetworking().getNewsFromReddit { (listings: [articleLink]) in
            print("operation complete")
            self.shots = listings
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ShotCollectionViewController.refreshInvoked(_:)), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    func refreshInvoked(_ sender:AnyObject) {
        sender.beginRefreshing()
        collectionView?.reloadData()
        sender.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredShots.count
        }
        return shots.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier_Shot, for: indexPath) as! ShotCollectionViewCell
        
        var shot: articleLink?
        
        if isSearching {
            shot = filteredShots[indexPath.row]
        } else {
            shot = shots[indexPath.row]
        }
        
        
        cell.imageView.sd_setImage(with: URL(string: shot!.thumb!)!)
//        cell.imageView.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        cell.imageView.layer.shadowOpacity = 0.8
//        cell.imageView.layer.shadowRadius = 5
        
//        cell.designerIcon.sd_setImage(with: URL(string: shot.avatarUrl)!)
//        cell.designerIcon.layer.cornerRadius = cell.designerIcon.bounds.width / 2
//        cell.designerIcon.layer.masksToBounds = true
        
        cell.shotName.text = shot!.title
//        cell.designerName.text = shot.designerName
//        cell.viewLabel.text = String(shot.shotCount)
        
        
//        if shots.count - 1 == indexPath.row && shotPages < 5 {
//            shotPages += 1
//            print(shotPages)
//            let url = API_URL + "&page=" + String(shotPages)
//            
//            
////            DribbleObjectHandler.getShots(url, callback: {(shots) -> Void in
//////                self.shots = shots
////                
////                for shot in shots {
////                    self.shots.append(shot)
////                }
////            })
//        }
        
//        cell.imageView.bounds = CGRectMake(0, 0, cellWidth, cellHeight)
//        cell.imageView.frame = cell.imageView.bounds
//        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        
//        cell.animatedImageView.bounds = CGRectMake(0, 0, cellWidth, cellHeight)
//        cell.animatedImageView.frame = cell.animatedImageView.bounds
//        cell.animatedImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
//        cell.contentView.backgroundColor = UIColor.yellowColor()
        
//        let imageLoadQueue = dispatch_queue_create("imageLoadQueue", nil)
//        
//        SDWebImageDownloader.sharedDownloader().downloadImageWithURL(
//            NSURL(string: shot.imageUrl),
//            options: SDWebImageDownloaderOptions.UseNSURLCache,
//            progress: nil,
//            completed: { (image: UIImage!, data: NSData!, error: NSError!, finished: Bool) -> Void in
//                if finished {
//                    dispatch_async(imageLoadQueue, {
//                        let animatedImage = FLAnimatedImage(animatedGIFData: data)
//                        if let animatedImage = animatedImage {
//                            dispatch_async(dispatch_get_main_queue(), {
//                                cell.animatedImageView.animatedImage = FLAnimatedImage(GIFData: data)
//                            })
//                        }
//                    })
//                }
//                
//        })
        
        //        DribbleObjectHandler.asyncLoadShotImage(shot, imageView: cell.imageView)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        if(indexPath.row % 3 == 0){
            return CGSize(width: cellWidth*2 - cellHorizontalMargin, height: cellHeight + 50);
//        }
//        return CGSize(width: cellWidth - cellHorizontalMargin, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellVerticalMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let _ = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier_Shot, for: indexPath) as! ShotCollectionViewCell
//        let shot = shots[indexPath.row]
//        let vc = ImageModalViewController(nibName: "ImageModalViewController", bundle: nil)
////        var vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .crossDissolve
////        vc.parentNavigationController = parentNavigationController
//        vc.pageUrl = shot.htmlUrl
//        vc.shotName = shot.shotName
//        vc.designerName = shot.designerName
//        
//        let downloadQueue = DispatchQueue(label: "com.naoyashiga.processdownload", attributes: [])
//        
//        downloadQueue.async{
//            let data = try? Data(contentsOf: URL(string: shot.imageUrl)!)
//            
//            var image: UIImage?
//            
//            if data != nil {
//                shot.imageData = data
//                image = UIImage(data: data!)!
//            }
//            
//            DispatchQueue.main.async{
//                vc.imageView.image = image
//            }
//        }
//        
//        parent?.present(vc, animated: true, completion: nil)
////        self.parentNavigationController.pushViewController(vc, animated: true)
    }
}
