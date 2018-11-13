//
//  ModelStore.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 11/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ModelStore {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addUser(email: String, password: String, name: String, lastName: String, twitter: String, profileImage: UIImage, backgroundImage: UIImage, followingCount: Int, followersCount: Int) -> Void {
        let login = Login(context: self.context)
        login.email = email
        login.password = password
        
        let user = User(context: self.context)
        user.login = login
        user.name = name
        user.lastName = lastName
        user.fullName = "\(name) \(lastName)"
        user.twitter = twitter
        user.profileImage = UIImagePNGRepresentation(profileImage)
        user.backgroundImage = UIImagePNGRepresentation(backgroundImage)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addRestaurant(title: String, description: String, image: UIImage, createdAt: Date) -> Void {
        let restaurant = Restaurant(context: self.context)
        restaurant.title = title
        restaurant.info = description
        restaurant.image = UIImagePNGRepresentation(image)
        restaurant.createdAt = createdAt
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func signIn(email: String, password: String) -> Bool {
        let request = NSFetchRequest<Login>(entityName: "Login")
        let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "email == %@", <#T##args: CVarArg...##CVarArg#>)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "email == %@", email),
            NSPredicate(format: "password == %@", password)
            ])
        
        do {
            let result = try self.context.fetch(fetchRequest)
            if !result.isEmpty {
                return true
            } else {
                return false
            }
        } catch {
            print("Error fecthing user data")
            return false
        }
    }
    
    func findAllUsers() -> [User] {
        var users: [User] = []
        do {
            users = try self.context.fetch(User.fetchRequest())
        } catch {
            print("Error fecthing user data")
        }
        
        return users
    }
}
