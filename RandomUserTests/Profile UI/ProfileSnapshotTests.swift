//
//  ProfileSnapshotTests.swift
//  RandomUserTests
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import XCTest
@testable import RandomUser

class ProfileSnapshotTests: XCTestCase {
  func test_profileWithContent() {
    let profileViewModel = ProfileViewModel(loader: UserLoaderDummy())
    let sut = ProfileViewController(profileViewModel: profileViewModel)
    
    sut.loadViewIfNeeded()
    sut.display(UserInfoViewModel.prototype)
    
    assert(sut, mode: .light)
    assert(sut, mode: .dark)
  }
  
  private class UserLoaderDummy: UserLoader {
    func load(completion: @escaping (UserLoader.Result) -> Void) {}
  }
}

extension UserInfoViewModel {
  
  static let prototypeUser = makeUserItem(nameTitle: "Mr", 
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
                                          postcode: "B9Y 6D8").model
  
  static let prototype = UserInfoViewModel(user: UserInfoViewModel.prototypeUser)
}
