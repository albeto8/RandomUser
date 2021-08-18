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
  
  typealias Result = Swift.Result<User, Swift.Error>
  
  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
  
  func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .failure(let error):
        completion(.failure(error))
        
      default:
        break
      }
    }
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
    
    sut.load { _ in }
    
    XCTAssertEqual(client.requestedURLs, [url])
  }
  
  func test_load_deliversErrorOnClientError() {
    let (sut, client) = makeSUT()
    let clientError = NSError(domain: "anyError", code: 0)
    let exp = expectation(description: "Wait for completion")
        
    sut.load { receivedResult in
      switch receivedResult {
      case .failure(let error as NSError):
        XCTAssertEqual(error, clientError)
        
      default:
        XCTFail("Expected result \(clientError) got \(receivedResult) instead")
      }
      exp.fulfill()
    }
    
    client.complete(with: clientError)
    
    wait(for: [exp], timeout: 0.1)
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
