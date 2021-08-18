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
    let sut = ProfileViewController()
    
    sut.loadViewIfNeeded()
    
    record(sut, mode: .light)
    record(sut, mode: .dark)
  }
}
