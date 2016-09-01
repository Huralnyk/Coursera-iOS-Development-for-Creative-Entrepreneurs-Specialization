//
//  MeViewController.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit
import MapKit

class MeViewController: HobbyShareViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
    }
    
    
    override func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        super.locationManager(manager, didUpdateLocations: locations)
        
        latitudeLabel.text = "Latitude: \(currentLocation!.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(currentLocation!.coordinate.longitude)"
    }
    
    
    @IBAction func saveButtonPressed(sender: AnyObject?) {
        if validate() {
            submit()
        }
    }
    
    
    func validate() -> Bool {
        return usernameField.text != nil && usernameField.text!.characters.count > 0
    }
    
    func submit() {
        usernameField.resignFirstResponder()
        
        let requestUser = User(userName: usernameField.text!)
        requestUser.latitude = currentLocation?.coordinate.latitude
        requestUser.longitude = currentLocation?.coordinate.longitude
        
        UserDP().getAccountForUser(requestUser) { returnedUser in
            if returnedUser.status.code == 0 {
                self.myHobbies = returnedUser.hobbies
                NSUserDefaults.standardUserDefaults().setValue(returnedUser.userID, forKey: "CurrentUserID")
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                self.showError(returnedUser.status.statusDescription!)
            }
        }
    }
    
}


extension MeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if validate() {
            submit()
        } else {
            showError("Did you enter an username?")
        }
        
        return true
    }
    
}


