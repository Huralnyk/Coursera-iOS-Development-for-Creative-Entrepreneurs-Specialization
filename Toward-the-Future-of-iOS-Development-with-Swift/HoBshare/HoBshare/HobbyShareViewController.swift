//
//  HobbyShareViewController.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit
import MapKit

class HobbyShareViewController: UIViewController {

    @IBOutlet weak var hobbiesCollectionView: UICollectionView!
    
    let availableHobbies: [String: [Hobby]] = HobbyDP().fetchHobbies()
    
    var myHobbies: [Hobby]? {
        didSet {
            hobbiesCollectionView.reloadData()
            saveHobbiesToUserDefaults()
        }
    }
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.stopUpdatingLocation()
            locationManager.startUpdatingLocation()
        default:
            break
        }
        
        getHobbies()
    }
    
    func saveHobbiesToUserDefaults() {
        let hobbiesData = NSKeyedArchiver.archivedDataWithRootObject(myHobbies!)
        NSUserDefaults.standardUserDefaults().setValue(hobbiesData, forKey: "MyHobbies")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getHobbies() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("MyHobbies") as? NSData {
            let savedHobbies = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Hobby]
            myHobbies = savedHobbies
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: kApplicationTitle, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}


extension HobbyShareViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager.stopUpdatingLocation()
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.debugDescription)
    }
    
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error.debugDescription)
    }
}

extension HobbyShareViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == hobbiesCollectionView {
            return 1
        } else {
            return availableHobbies.keys.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hobbiesCollectionView {
            guard let myHobbies = myHobbies else { return 0 }
            return myHobbies.count
        } else {
            let key = Array(availableHobbies.keys)[section]
            return availableHobbies[key]!.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HobbyCollectionViewCell", forIndexPath: indexPath) as! HobbyCollectionViewCell
        
        if collectionView == hobbiesCollectionView {
            let hobby = myHobbies![indexPath.item]
            cell.hobbyLabel.text = hobby.hobbyName
        } else {
            let key = Array(availableHobbies.keys)[indexPath.section]
            let hobbies = availableHobbies[key]
            let hobby = hobbies![indexPath.item]
            cell.hobbyLabel.text = hobby.hobbyName
        }
        
        return cell
    }
}

extension HobbyShareViewController: UICollectionViewDelegate {}

extension HobbyShareViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let numberOfCells: Int
        let padding: Int
        
        if collectionView == hobbiesCollectionView {
            numberOfCells = collectionView.numberOfItemsInSection(indexPath.section)
            padding = 10
        } else {
            numberOfCells = 2
            padding = 10
        }
        
        let cellHeight: CGFloat = 54
        let availableWidth = collectionView.frame.width - CGFloat(padding * (numberOfCells - 1))
        let dynamicCellWidth = availableWidth / CGFloat(numberOfCells)
        
        return CGSize(width: dynamicCellWidth, height: cellHeight)
    }

}
