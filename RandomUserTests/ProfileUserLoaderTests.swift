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
  
  enum Error: Swift.Error {
    case invalidData
  }
  
  func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedUser = try? ProfileUserMapper.map(data: data) else {
          completion(.failure(Error.invalidData))
          return
        }
        
        completion(.success(mappedUser))
      
      case .failure(let error):
        completion(.failure(error))
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
    let clientError = NSError(domain: "clientError", code: 0)
        
    expect(sut, completesWith: clientError, when: {
      client.complete(with: clientError)
    })
  }
  
  func test_load_deliversInvalidDataErrorOnSuccessfulRespondeWithInvalidData() {
    let (sut, client) = makeSUT()
        
    expect(sut, completesWith: ProfileUserLoader.Error.invalidData, when: {
      client.complete(withStatusCode: 200, data: Data("invalid json".utf8))
    })
  }
  
  func test_load_deliversUserOnClientSuccessfulResponse() {
    let (sut, client) = makeSUT()
    let userItem = makeUserItem(nameTitle: "Mr", 
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
    let json = makeJSON(userItem.json)
    let exp = expectation(description: "Wait for completion")
    
    let expectedUser = userItem.model
    
    sut.load { receivedResult in
      switch receivedResult {
      case .success(let receivedUser):
        XCTAssertEqual(expectedUser, receivedUser)
        
      default:
        XCTFail("Expected result \(expectedUser) got \(receivedResult) instead")
      }
      
      exp.fulfill()
    }
    
    
    client.complete(withStatusCode: 200, data: json)
    
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
  
  private func expect(_ sut: ProfileUserLoader, completesWith expectedError: Error, when action: () -> Void) {
    let exp = expectation(description: "Wait for completion")
    
    sut.load { receivedResult in
      switch receivedResult {
      case .failure(let error as NSError):
        XCTAssertEqual(error, expectedError as NSError)
        
      default:
        XCTFail("Expected result \(expectedError) got \(receivedResult) instead")
      }
      
      exp.fulfill()
    }
    
    action()
    
    wait(for: [exp], timeout: 0.1)
  }
}
