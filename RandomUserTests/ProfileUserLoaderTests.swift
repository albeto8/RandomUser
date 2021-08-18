//
//  ProfileUserLoaderTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest
import RandomUser

final class ProfileUserLoader {
  private let url: URL
  private let client: HTTPClient
  
  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
  
  func load() {
    client.get(from: url) { _ in }
  }
}

class ProfileUserLoaderTests: XCTestCase {
  func test_init_doesNotRequestURL() {
    let client = HTTPClientSpy()
    let _ = ProfileUserLoader(url: URL(string: "http://any-url.com")!, client: client)
    
    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }
  
  func test_load_requestsDataFromURL() {
    let url = URL(string: "http://any-url.com")!
    let client = HTTPClientSpy()
    let sut = ProfileUserLoader(url: url, client: client)
    
    sut.load()
    
    XCTAssertEqual(client.requestedURLs, [url])
  }
}
