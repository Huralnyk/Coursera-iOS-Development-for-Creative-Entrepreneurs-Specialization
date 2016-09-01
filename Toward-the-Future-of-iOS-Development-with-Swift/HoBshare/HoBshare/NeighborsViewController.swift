//
//  NeighborsViewController.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit
import MapKit

class NeighborsViewController: HobbyShareViewController {

    @IBOutlet weak var mapView: MKMapView!
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hobbiesCollectionView.reloadData()
    }
    
    override func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        super.locationManager(manager, didUpdateLocations: locations)
        centerMapOnCurrentLocation()
    }
    
    private func centerMapOnCurrentLocation() {
        guard let currentLocation = currentLocation else {
            print("Current location unavailable")
            return
        }
        
        mapView.setCenterCoordinate(currentLocation.coordinate, animated: true)
        
        let currentRegion = mapView.regionThatFits(MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
        mapView.setRegion(currentRegion, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let users = users {
            mapView.removeAnnotations(users)
        }
        
        fetchUsersWithHobby(myHobbies![indexPath.row])
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HobbyCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HobbyCollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()
    }
    
    private func fetchUsersWithHobby(hobby: Hobby) {
        guard let userID = NSUserDefaults.standardUserDefaults().valueForKey("CurrentUserID") as? String where userID.characters.count > 0 else {
            let alert = UIAlertController(title: "hoBshare", message: "Please login before selecting a hobby", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alert.addAction(okayAction)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // REST call
        
        let requestedUser = User()
        requestedUser.userID = userID
        requestedUser.latitude = currentLocation?.coordinate.latitude
        requestedUser.longitude = currentLocation?.coordinate.longitude
        
        UserDP().fetchUsersForHobby(requestedUser, hobby: hobby) { returnedListOfUsers in
            if returnedListOfUsers.status.code == 0 {
                
                // get rid of the last set of users and remove their annotations from the map
                if let users = self.users {
                    self.mapView.removeAnnotations(users)
                }
                
                self.users = returnedListOfUsers.users
                
                // create a pin for each user
                if let users = self.users {
                    
                    for user in users {
                        self.mapView.addAnnotation(user)
                    }
                    
                    // zoom to show the nearest users in relation to the current user's location
                    if self.currentLocation != nil {
                        let me = User(userName: "Me", hobbies: self.myHobbies!, latitude: self.currentLocation!.coordinate.latitude, longitude: self.currentLocation!.coordinate.longitude)
                        self.mapView.addAnnotation(me)
                        let neighborsAndMe = users + [me]
                        self.mapView.showAnnotations(neighborsAndMe, animated: true)
                    } else {
                        self.mapView.showAnnotations(users, animated: true)
                    }
                }
                
            } else {
                self.showError(returnedListOfUsers.status.statusDescription!)
            }
        }
        
    }
}


extension NeighborsViewController: MKMapViewDelegate {
    
    
}
