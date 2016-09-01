//
//  EditHobbiesViewController.swift
//  HoBshare
//
//  Created by Alexey Huralnyk on 6/29/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

import UIKit

class EditHobbiesViewController: HobbyShareViewController {
    
    @IBOutlet weak var availableHobbiesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        availableHobbiesCollectionView.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HobbyCategoryHeader", forIndexPath: indexPath)
        
        (reusableView as! HobbyCollectionViewHeader).categoryLabel.text = Array(availableHobbies.keys)[indexPath.section]
        
        return reusableView
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        
        if collectionView == availableHobbiesCollectionView {
            let key = Array(availableHobbies.keys)[indexPath.section]
            let hobbies = availableHobbies[key]!
            let hobby = hobbies[indexPath.item]
            
            if myHobbies?.contains({ $0.hobbyName == hobby.hobbyName }) == true {
                cell.backgroundColor = UIColor.redColor()
            } else {
                cell.backgroundColor = UIColor.darkGrayColor()
            }
        }
        
        return cell
    }
    
    func saveHobbies() {
        let requestUser = User()
        
        requestUser.userID = NSUserDefaults.standardUserDefaults().valueForKey("CurrentUserID") as? String
        
        if let myHobbies = myHobbies {
            requestUser.hobbies = myHobbies
            
            HobbyDP().saveHobbiesForUser(requestUser) { returnedUser in
                if returnedUser.status.code == 0 {
                    self.saveHobbiesToUserDefaults()
                    self.hobbiesCollectionView.reloadData()
                    self.availableHobbiesCollectionView.reloadData()
                } else {
                    self.showError(returnedUser.status.statusDescription!)
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == availableHobbiesCollectionView {
            let key = Array(availableHobbies.keys)[indexPath.section]
            let hobbies = availableHobbies[key]!
            let hobby = hobbies[indexPath.item]
            
            if myHobbies?.contains({ $0.hobbyName == hobby.hobbyName }) == false {
                if myHobbies!.count < kMaxHobbies {
                    myHobbies! += [hobby]
                    self.saveHobbies()
                } else {
                    let alert = UIAlertController(title: "hoBshare",
                                                  message: "You may only select up to \(kMaxHobbies) hobbies. Would you like to replace one of the following hobbies.",
                                                  preferredStyle: .Alert)
                    
                    for i in 0 ..< myHobbies!.count {
                        let selectedHobby = myHobbies![i]
                        let replaceAction = UIAlertAction(title: selectedHobby.hobbyName, style: .Destructive, handler: { _ in
                            self.myHobbies![i] = hobby
                            self.saveHobbies()
                        })
                        alert.addAction(replaceAction)
                    }
                    
                    let okayAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                    alert.addAction(okayAction)
                    presentViewController(alert, animated: true, completion: nil)
                }
            }
            
        } else {
            let alert = UIAlertController(title: "hoBshare", message: "Would you like to delete this hobby?", preferredStyle: .ActionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { _ in
                self.myHobbies!.removeAtIndex(indexPath.item)
                self.saveHobbies()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}
