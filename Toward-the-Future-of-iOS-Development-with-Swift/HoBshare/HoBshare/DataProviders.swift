//
//  DataProviders.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit

let serverPath = "http://uci.smilefish.com/HBSRest-Dev/api/"
let endpoint = "HobbyRest"

class UserDP: NSObject {
    
    func getAccountForUser(user: User, completion: (User) -> Void) {
        let requestURLString = serverPath + endpoint
        let HTTPMethod = "CREATE_USER"
        let requestModel = user
        
        SFLConnection().ajax(requestURLString, verb: HTTPMethod, requestBody: requestModel) { jsonDict in
            let dict = NSDictionary(dictionary: jsonDict)
            
            let returnedUser = User()
            returnedUser.readFromJSONDictionary(dict)
            
            completion(returnedUser)
        }
    }
    
    func fetchUsersForHobby(user: User, hobby: Hobby, completion: (ListOfUsers) -> Void) {
        let requestURL = serverPath + endpoint
        let HTTPMethod = "FETCH_USERS_WITH_HOBBY"
        let requestModel = user
        
        requestModel.searchHobby = hobby
        
        SFLConnection().ajax(requestURL, verb: HTTPMethod, requestBody: requestModel) { jsonDict in
            let dict = NSDictionary(dictionary: jsonDict)
            
            let returnedListOfUsers = ListOfUsers()
            returnedListOfUsers.readFromJSONDictionary(dict)
            
            completion(returnedListOfUsers)
        }
    }
}

class HobbyDP: NSObject {
    
    func fetchHobbies() -> [String : [Hobby]] {
        return [
            "TECHNOLOGY" : [
                Hobby(hobbyName: "Video Games"),
                Hobby(hobbyName: "Computers"),
                Hobby(hobbyName: "IDEs"),
                Hobby(hobbyName: "Smartphones"),
                Hobby(hobbyName: "Programming"),
                Hobby(hobbyName: "Electronics"),
                Hobby(hobbyName: "Gadgets"),
                Hobby(hobbyName: "Product Reviews"),
                Hobby(hobbyName: "Computer Repair"),
                Hobby(hobbyName: "Software"),
                Hobby(hobbyName: "Hardware"),
                Hobby(hobbyName: "Apple"),
                Hobby(hobbyName: "Google"),
                Hobby(hobbyName: "Microsoft")
            ]
        ]
    }
    
    func saveHobbiesForUser(user: User, completion: (User) -> Void) {
        let requestURLString = serverPath + endpoint
        let HTTPMethod = "SAVE_HOBBIES"
        let requestModel = user
        
        SFLConnection().ajax(requestURLString, verb: HTTPMethod, requestBody: requestModel) { jsonDict in
            let returnedUser = User()
            returnedUser.readFromJSONDictionary(jsonDict)
            completion(returnedUser)
        }
    }
}
