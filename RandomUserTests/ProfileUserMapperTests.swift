//
//  ProfileUserMapperTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest

final class ProfileUserMapper {
  
  enum Error: Swift.Error {
    case inavalidData
  }
  
  static func map(data: Data) throws {
    throw Error.inavalidData
  }
}


class ProfileUserMapperTests: XCTestCase {
  func test_map_throwsErrorWithInvalidJSON() throws {
    let invalidJSON = Data("invalid json".utf8)
    
    XCTAssertThrowsError(try ProfileUserMapper.map(data: invalidJSON))
  }  
}
