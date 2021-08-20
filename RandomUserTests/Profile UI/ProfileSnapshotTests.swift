//
//  ProfileSnapshotTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import XCTest
@testable import RandomUseriOS
@testable import UserFeature

class ProfileSnapshotTests: XCTestCase {
  func test_profileWithContent() {
    let sut = makeSUT()
    
    sut.display(UserInfoViewModel<UIImage>(user: User.prototypeUser, 
                                           imageLoader: UserImageDataLoaderDummy(),
                                           imageTransformer: UIImage.init))
    
    sut.display(userImage: UIImage(named: "randomUser1", in: Bundle(for: ProfileViewController.self), with: nil)!)
        
    assert(sut, mode: .light)
    assert(sut, mode: .dark)
  }
  
  // MARK: - Helpers
  
  private func makeSUT(file: StaticString = #file, line: UInt = #line) -> ProfileViewController {
    let profileViewModel = ProfileViewModel(loader: UserLoaderDummy())
    let sut = ProfileViewController(profileViewModel: profileViewModel)
    
    sut.loadViewIfNeeded()
    
    return sut
  }
  
  private class UserLoaderDummy: UserLoader {
    func load(completion: @escaping (UserLoader.Result) -> Void) {
      completion(.success(User.prototypeUser))
    }
  }
  
  private class UserImageDataLoaderDummy: UserImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (UserImageDataLoader.Result) -> Void) -> UserImageDataLoaderTask {      
      return UserImageDataLoaderTaskDummy()
    }
  }
  
  private struct UserImageDataLoaderTaskDummy: UserImageDataLoaderTask {
    func cancel() {}
  }
}

extension User {
  
  static let prototypeUser = User(nameTitle: "Mr", 
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
                                          address: Address(
                                          streetNumber: 12, 
                                          streetName: "Pine Rd", 
                                          city: "Field", 
                                          state: "Newfoundland and Labrador", 
                                          country: "Canada", 
                                          latitude: "-68.1548", 
                                          longitude: "-73.3002"))
}
