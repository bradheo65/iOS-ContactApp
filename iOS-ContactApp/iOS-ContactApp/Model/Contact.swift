//
//  Contact.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/26.
//

import Foundation

struct Contact: Codable, Hashable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

struct Address: Codable, Hashable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Codable, Hashable {
    let lat, lng: String
}

struct Company: Codable, Hashable {
    let name, catchPhrase, bs: String
}

