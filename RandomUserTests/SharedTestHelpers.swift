//
//  SharedTestHelpers.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation
import RandomUser

func makeUserItem(nameTitle: String,
                          firstName: String, 
                          lastName: String,
                          gender: String,
                          email: String,
                          birthDay: String,
                          age: Int,
                          phone: String,
                          cellPhone: String,
                          userPictureURL: URL,
                          registrationDate: String,
                          streetNumber: Int,
                          streetName: String,
                          city: String,
                          state: String,
                          country: String,
                          latitude: String,
                          longitude: String,
                          postcode: String) -> (model: User, json: [String: Any]) {
  
  let nameJSON = [
    "title": nameTitle,
    "first": firstName,
    "last": lastName
  ]
  
  let streetJSON: [String: Any] = [
    "number": streetNumber,
    "name": streetName
  ]
  
  let locationJSON: [String: Any] = [
    "street": streetJSON,
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "coordinates": ["latitude": latitude, "longitude": longitude]
  ]
  
  let dobJSON: [String: Any] = [
    "date": birthDay,
    "age": age
  ]
  
  let registeredJSON: [String: Any] = [
    "date": registrationDate
  ]
  
  let json: [String: Any] = [
    "gender": gender,
    "name": nameJSON,
    "location": locationJSON,
    "email": email,
    "dob": dobJSON,
    "registered": registeredJSON,
    "phone": phone,
    "cell": cellPhone,
    "picture": ["large": userPictureURL.absoluteString]
  ]
  
  let model = User(nameTitle: nameTitle, 
                   firstName: firstName, 
                   lastName: lastName, 
                   gender: gender, 
                   email: email, 
                   birthDay: birthDay, 
                   age: age, 
                   phone: phone, 
                   cellPhone: cellPhone, 
                   userPictureURL: userPictureURL, 
                   registrationDate: registrationDate, 
                   address: Address(streetNumber: streetNumber, 
                                    streetName: streetName, 
                                    city: city, 
                                    state: state, 
                                    country: country, 
                                    latitude: latitude, 
                                    longitude: longitude))
  
  return (model, json)
}

func makeJSON(_ item: [String: Any]) -> Data {
  let root = ["results": [item]]
  return try! JSONSerialization.data(withJSONObject: root)
}
