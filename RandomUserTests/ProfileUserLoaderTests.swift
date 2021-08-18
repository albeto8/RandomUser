//
//  ProfileUserLoaderTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest
import RandomUser

final class ProfileUserLoader {
  private let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
}

class ProfileUserLoaderTests: XCTestCase {
  func test_init_doesNotRequestURL() {
    let client = HTTPClientSpy()
    let _ = ProfileUserLoader(client: client)
    
    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }
}
