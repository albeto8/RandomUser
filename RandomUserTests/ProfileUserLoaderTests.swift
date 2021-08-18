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
    let (_, client) = makeSUT()
    
    XCTAssertEqual(client.requestedURLs, [], "Client should not request url on init")
  }
  
  func test_load_requestsDataFromURL() {
    let url = URL(string: "http://any-url.com")!
    let (sut, client) = makeSUT(with: url)
    
    sut.load()
    
    XCTAssertEqual(client.requestedURLs, [url])
  }
  
  // MARK: - Helpers
  
  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!, 
                       file: StaticString = #file, 
                       line: UInt = #line) -> (sut: ProfileUserLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = ProfileUserLoader(url: url, client: client)
    
    return (sut, client)
  }
}
