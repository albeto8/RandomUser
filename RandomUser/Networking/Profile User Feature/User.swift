//
//  User.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public struct User: Equatable {
  let nameTitle: String
  let firstName: String
  let lastName: String
  let gender: String
  let email: String
  let birthDay: String
  let age: Int
  let phone: String
  let cellPhone: String
  let userPictureURL: URL?
  let registrationDate: String 
  let address: Address
  
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
  let streetNumber: Int
  let streetName: String
  let city: String
  let state: String
  let country: String
  let latitude: String
  let longitude: String
  
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
