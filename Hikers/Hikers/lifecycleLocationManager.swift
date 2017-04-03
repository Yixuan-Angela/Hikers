//
//  lifecycleLocationManager.swift
//  
//
//  Created by Rafi Rizwan on 2/22/17.
//
//

import UIKit
import CoreLocation


class lifecycleLocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationCompletionHandler: ((CLLocation)->Void)?
    
    static let sharedInstance = lifecycleLocationManager()
    internal var internalManager: CLLocationManager = CLLocationManager()
    internal var origin: CLLocation? = nil
    internal var currentLocation: CLLocation? = nil
    internal var majorLocationChanges: [CLLocation]? = nil
    internal var receivedLocation: Bool = false
    
    func initialize(){
        internalManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        internalManager.delegate = self
        internalManager.requestAlwaysAuthorization()
        majorLocationChanges = [CLLocation]()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first?.coordinate.latitude ?? 0)
        print(locations.first?.coordinate.longitude ?? 0)
        
        if origin == nil{
            origin = locations.first
            majorLocationChanges?.append(locations.first!)
            currentLocation = locations.first
            locationCompletionHandler?(currentLocation!)
            receivedLocation = true
        }
        
        currentLocation = locations.first
        if receivedLocation == false && (locations.first?.distance(from: (majorLocationChanges?.last)!))! > 150.0{
            // .. statements below will only be triggered in the event that the last requested location is greater than 150 metres away.
            // this reduces load on the server to actually give a new set of data every time someone has moved a relatively insignificant amount.
            // in future this variable should be changed based off of a user's learned preference.
            
            majorLocationChanges?.append(locations.first!)
            locationCompletionHandler?(currentLocation!)
            receivedLocation = true
        }
        internalManager.stopUpdatingLocation()
    }
    
    func getLocation(completion: @escaping (CLLocation) -> Void){
        receivedLocation = false
        locationCompletionHandler = completion
        internalManager.startUpdatingLocation()
    }
    
    func getPermissionStatus() -> Bool{
        
        return false
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        // do something
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        //do something
    }

}
