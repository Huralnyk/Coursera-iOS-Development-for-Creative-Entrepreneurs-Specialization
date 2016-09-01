//
//  Models.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit
import MapKit

extension Array {
    
    var allValuesAreHobbies: Bool {
        var returnValue = true
        for value in self {
            if value is Hobby == false {
                returnValue = false
            }
        }
        return returnValue
    }
    
    func toString() -> String {
        var returnString = ""
        
        if allValuesAreHobbies {
            for i in 0 ..< count {
                let value = self[i] as! Hobby
                
                if i == 0 {
                    returnString += value.hobbyName!
                } else {
                    returnString += ", " + value.hobbyName!
                }
            }
        }
        
        return returnString
    }
}

class User: SFLBaseModel, JSONSerializable {
    
    var userID: String?
    var userName: String?
    var latitude: Double?
    var longitude: Double?
    var hobbies: [Hobby] = []
    var searchHobby: Hobby?
    
    override init() {
        super.init()
        self.delegate = self
    }
    
    init(userName: String) {
        super.init()
        self.delegate = self
        self.userName = userName
    }
    
    convenience init(userName: String, hobbies: [Hobby], latitude: Double, longitude: Double) {
        self.init(userName: userName)
        self.hobbies = hobbies
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override func getJSONDictionary() -> NSDictionary {
        let dictionary = super.getJSONDictionary()
        
        dictionary.setValue(userID ?? nil, forKey: "UserId")
        dictionary.setValue(userName ?? nil, forKey: "Username")
        dictionary.setValue(latitude ?? nil, forKey: "Latitude")
        dictionary.setValue(longitude ?? nil, forKey: "Longitude")
        dictionary.setValue(searchHobby?.hobbyName ?? nil, forKey: "HobbySearch")
        
        var jsonSafeHobbiesArray: [String] = []
        
        for hobby in hobbies {
            jsonSafeHobbiesArray.append(hobby.hobbyName!)
        }
        
        dictionary.setValue(jsonSafeHobbiesArray, forKey: "Hobbies")
        
        return dictionary
    }
    
    override func readFromJSONDictionary(dict: NSDictionary) {
        super.readFromJSONDictionary(dict)
        
        self.userID = dict["UserId"] as? String
        self.userName = dict["Username"] as? String
        self.latitude = dict["Latitude"] as? Double
        self.longitude = dict["Longitude"] as? Double
        
        if let hobbies = dict["Hobbies"] as? NSArray {
            self.hobbies = Hobby.deserializedHobbies(hobbies)
        }
    }
}

extension User: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    
    var title: String? {
        return userName
    }
    
    var subtitle: String? {
        var hobbiesAsString = ""
        
        print(userName! + ": " + hobbies.toString() )
        hobbiesAsString = hobbies.toString()
        
        return hobbiesAsString
    }

}

class ListOfUsers: SFLBaseModel, JSONSerializable {
    
    var users: [User] = []
    
    override init() {
        super.init()
        self.delegate = self
    }
    
    override func readFromJSONDictionary(dict: NSDictionary) {
        super.readFromJSONDictionary(dict)
        
        if let returnedUsers = dict["ListOfUsers"] as? NSArray {
            for dict in returnedUsers {
                let user = User()
                user.readFromJSONDictionary(dict as! NSDictionary)
                users.append(user)
            }
        }
    }
    
    override func getJSONDictionary() -> NSDictionary {
        return super.getJSONDictionary()
    }
    
    override func getJSONDictionaryString() -> NSString {
        return super.getJSONDictionaryString()
    }
    
    
}

class Hobby: SFLBaseModel, NSCoding {
 
    var hobbyName: String?
    
    init(hobbyName: String) {
        super.init()
        self.hobbyName = hobbyName
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.hobbyName = aDecoder.decodeObjectForKey("HobbyName") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(hobbyName, forKey: "HobbyName")
    }
    
    class func deserializedHobbies(hobbies: NSArray) -> [Hobby] {
        var returnedArray: [Hobby] = []
        
        for hobby in hobbies {
            if let hobbyName = hobby as? String {
                returnedArray.append(Hobby(hobbyName: hobbyName))
            }
        }
        
        return returnedArray
    }
}
