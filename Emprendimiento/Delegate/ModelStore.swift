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
    
    func addCreditCard(owner: String, cardNumber: String, expirationMonth: Int, expirationYear: Int, cvc: String) -> Void {
        let creditCard = CreditCard(context: self.context)
        creditCard.owner = owner
        creditCard.cardNumber = cardNumber
        creditCard.expirationMonth = Int32(expirationMonth)
        creditCard.expirationYear = Int32(expirationYear)
        creditCard.cvc = cvc
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func signIn(email: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "email == %@", email),
            NSPredicate(format: "password == %@", password)
            ])
        
        do {
            let result = try self.context.fetch(fetchRequest)
            if !result.isEmpty {
                print("My response: \(result[0].user!.objectID)")
                UserDefaults.standard.set(result[0].user!.objectID.uriRepresentation(), forKey: "userId")
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
    
    func findUser(id: URL) -> User {
        var user: User = User(context: self.context)
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let userId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: id)
        
        do {
            let object = try self.context.existingObject(with: userId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            user = try self.context.fetch(fetchRequest)[0]
            
            print("user: \(user)")
        } catch {
            print("Error fecthing user data with objectId")
        }
        
        return user
    }
}
