//
//  UserInfoViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation

final class UserInfoViewModel {
  private let user: User
  
  init(user: User) {
    self.user = user
  }
  
  var fullname: String {
    "\(user.nameTitle) \(user.firstName) \(user.lastName)"
  }
  
  var email: String {
    "\(user.email)"
  }
  
  var memberSince: String {
    user.registrationDate
  }
  
  var age: String {
    "\(user.age) Years"
  }
  
  var birthday: String {
    "\(user.birthDay)"
  }
  
  var gender: String {
    "\(user.gender)"
  }
  
  var emergencyPhone: String {
    "\(user.phone)"
  }
  
  var address: String {
    "\(user.address.streetNumber) \(user.address.streetName)  \(user.address.city) \(user.address.state) \(user.address.country)"
  }
}
