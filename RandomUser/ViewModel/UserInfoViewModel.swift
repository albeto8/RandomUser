//
//  UserInfoViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

final class UserInfoViewModel {
  private let user: User
  
  init(user: User) {
    self.user = user
  }
  
  var fullname: String {
    "\(user.nameTitle). \(user.firstName) \(user.lastName)"
  }
  
  var email: String {
    "\(user.email)"
  }
  
  var memberSince: String {
    let isoDate = user.registrationDate
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    if let date = dateFormatter.date(from:isoDate) {
      let formate = date.getFormattedDate(format: "yyyy")
      
      return "Member since \(formate)"
    }
    
    return ""
  }
  
  var age: String {
    "\(user.age) Years"
  }
  
  var birthday: String {
    let isoDate = user.birthDay
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    if let date = dateFormatter.date(from:isoDate) {
      let formate = date.getFormattedDate(format: "MM/dd")
      
      return "\(formate)"
    }
    
    return ""
  }
  
  var gender: String {
    "\(user.gender)"
  }
  
  var emergencyPhone: String {
    "\(user.phone)"
  }
  
  var address: String {
    "\(user.address.streetNumber) \(user.address.streetName), \(user.address.city), \(user.address.state), \(user.address.country)"
  }
}
