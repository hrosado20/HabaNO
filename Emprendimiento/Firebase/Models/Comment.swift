//
//  Comment.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 21/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseDatabase

public class Comment {
    var id: String
    var userImage: String
    var userName: String
    var comment: String
    
    public init() {
        self.id = ""
        self.userImage = ""
        self.userName = ""
        self.comment = ""
    }
    
    public init(id: String, userImage: String, userName: String, comment: String) {
        self.id = id
        self.userImage = userImage
        self.userName = userName
        self.comment = comment
    }
    
    public convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject[Constants.firebaseKeys.id].stringValue,
                  userImage: jsonObject[Constants.firebaseKeys.userImage].stringValue,
                  userName: jsonObject[Constants.firebaseKeys.userName].stringValue,
                  comment: jsonObject[Constants.firebaseKeys.comment].stringValue)
    }
    
    public convenience init(fromFirebaseSnapshot snapshot: DataSnapshot) {
        let dictionary = snapshot.value as! NSDictionary
        self.init(id: dictionary[Constants.firebaseKeys.id] as! String,
                  userImage: dictionary[Constants.firebaseKeys.userImage] as! String,
                  userName: dictionary[Constants.firebaseKeys.userName] as! String,
                  comment: dictionary[Constants.firebaseKeys.comment] as! String)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Comment] {
        var modelList = [Comment]()
        for i in 0..<jsonArray.count {
            modelList.append(Comment.init(fromJSONObject: jsonArray[i]))
        }
        return modelList
    }
    
    public static func buildCollection(fromFirebaseSnapshot snapshot: DataSnapshot) -> [Comment] {
        var modelList = [Comment]()
        for child in snapshot.children.allObjects as! [DataSnapshot] {
            modelList.append(Comment.init(fromFirebaseSnapshot: child))
        }
        return modelList
    }
}
