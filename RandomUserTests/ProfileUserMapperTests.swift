//
//  ProfileUserMapperTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest
import RandomUser

class ProfileUserMapperTests: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)
    
    XCTAssertThrowsError(try ProfileUserMapper.map(data: invalidJSON))
  }
  
  func test_map_deliversUserWithValidJSON() throws {
    let user = makeUserItem(nameTitle: "Mr", 
                            firstName: "Maxime", 
                            lastName: "Anderson", 
                            gender: "male", 
                            email: "maxime.anderson@example.com", 
                            birthDay: "1948-09-15T02:16:45.171Z", 
                            age: 29, 
                            phone: "829-826-3101", 
                            cellPhone: "322-277-6834", 
                            userPictureURL: URL(string: "http://any-url.com")!, 
                            registrationDate: "2014-01-13T23:04:59.882Z", 
                            streetNumber: 12, 
                            streetName: "Pine Rd", 
                            city: "Field", 
                            state: "Newfoundland and Labrador", 
                            country: "Canada", 
                            latitude: "-68.1548", 
                            longitude: "-73.3002", 
                            postcode: "B9Y 6D8")
    
    let result = try ProfileUserMapper.map(data: makeJSON(user.json))
    
    XCTAssertEqual(result, user.model)
  }
  
  // MARK: - Helpers
  
  private func makeUserItem(nameTitle: String,
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
                                      longitude: longitude, 
                                      postcode: postcode))
    
    return (model, json)
  }
  
  func makeJSON(_ item: [String: Any]) -> Data {
    let root = ["results": item]
    return try! JSONSerialization.data(withJSONObject: root)
  }
}
