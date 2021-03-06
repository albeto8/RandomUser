//
//  LoadUserFromRemoteUseCaseTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import XCTest
import UserFeature

class LoadUserFromRemoteUseCaseTests: XCTestCase {
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
        
    expect(sut, completesWith: .failure(clientError), when: {
      client.complete(with: clientError)
    })
  }
  
  func test_load_deliversInvalidDataErrorOnSuccessfulRespondeWithInvalidData() {
    let (sut, client) = makeSUT()
        
    expect(sut, completesWith: .failure(ProfileUserMapper.Error.invalidData), when: {
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
    
    expect(sut, completesWith: .success(userItem.model), when: {
      let json = makeJSON(userItem.json) 
      client.complete(withStatusCode: 200, data: json)
    })
  }
  
  // MARK: - Helpers
  
  private func makeSUT(with url: URL = URL(string: "http://any-url.com")!, 
                       file: StaticString = #file, 
                       line: UInt = #line) -> (sut: RemoteUserLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteUserLoader(url: url, client: client)
    
    return (sut, client)
  }
  
  private func expect(_ sut: RemoteUserLoader, completesWith expectedResult: RemoteUserLoader.Result, when action: () -> Void) {
    let exp = expectation(description: "Wait for completion")
    
    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedItem), .success(expectedItem)):
        XCTAssertEqual(receivedItem, expectedItem)
        
      case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
        XCTAssertEqual(receivedError, expectedError)
        
      default:
        XCTFail("Expected result \(expectedResult) got \(receivedResult) instead")
      }
      
      exp.fulfill()
    }
    
    action()
    
    wait(for: [exp], timeout: 0.1)
  }
}
