//
//  User.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public struct User: Equatable {
  public let nameTitle: String
  public let firstName: String
  public let lastName: String
  public let gender: String
  public let email: String
  public let birthDay: String
  public let age: Int
  public let phone: String
  public let cellPhone: String
  public let userPictureURL: URL?
  public let registrationDate: String 
  public let address: Address
  
  public init(nameTitle: String, firstName: String, lastName: String, gender: String, email: String, birthDay: String, age: Int, phone: String, cellPhone: String, userPictureURL: URL?, registrationDate: String, address: Address) {
    self.nameTitle = nameTitle
    self.firstName = firstName
    self.lastName = lastName
    self.gender = gender
    self.email = email
    self.birthDay = birthDay
    self.age = age
    self.phone = phone
    self.cellPhone = cellPhone
    self.userPictureURL = userPictureURL
    self.registrationDate = registrationDate
    self.address = address
  }
}

public struct Address: Equatable {
  public let streetNumber: Int
  public let streetName: String
  public let city: String
  public let state: String
  public let country: String
  public let latitude: String
  public let longitude: String
  
  public init(streetNumber: Int, streetName: String, city: String, state: String, country: String, latitude: String, longitude: String) {
    self.streetNumber = streetNumber
    self.streetName = streetName
    self.city = city
    self.state = state
    self.country = country
    self.latitude = latitude
    self.longitude = longitude
  }
}
