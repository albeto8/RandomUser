//
//  ProfileUserMapperTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest
import UserFeature

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
}
