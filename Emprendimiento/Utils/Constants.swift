//
//  Constants.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 15/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation

public class Constants {
    public struct keys {
        public static var token: String = "token"
        public static var refreshToken: String = "refreshToken"
        public static var userId: String = "userId"
        public static var didPopulateDatabase = "didPopulateDatabase"
    }
    public struct state {
        public static var active: String = "active"
        public static var activeInSpanish: String = "activo"
        public static var inactive: String = "inactive"
        public static var taken: String = "taken"
        public static var takenInSpanish: String = "consumido"
    }
    public static var header: String = "header"
    public static var accept: String = "application/json"
}
