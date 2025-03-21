//
//  UserModel.swift
//  MarketPlace
//
//  Created by dev on 07/03/2025.
//

import Foundation
struct UserAPIResults: Codable {
    var results: [User]
    var info: APIInfo
}
struct User: Codable {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var picture: Picture
}
struct Name: Codable {
    var title: String
    var first: String
    var last: String
}

struct Location: Codable {
    var city: String
    var state: String
    var coordinates: Coordinate
    
}
struct Coordinate: Codable {
    var latitude: String
    var longitude: String
}

struct Login: Codable {
    var uuid: String
    var username: String
    var password: String
}

struct APIInfo: Codable{
    var seed: String
    var results: Int
    var page: Int
    var version: String
}

struct Picture: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}
