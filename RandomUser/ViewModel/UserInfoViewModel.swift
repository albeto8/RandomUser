//
//  UserInfoViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation
import UserFeature

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

final class UserInfoViewModel<Image> {
  typealias Observer<T> = (T) -> Void
  
  private var task: UserImageDataLoaderTask?
  private let model: User
  private let imageLoader: UserImageDataLoader
  private let imageTransformer: (Data) -> Image?
  
  var onImageLoad: Observer<Image>?
  var onImageLoadingStateChange: Observer<Bool>?
  
  init(user: User, 
       imageLoader: UserImageDataLoader, 
       imageTransformer: @escaping (Data) -> Image?) {
    self.model = user
    self.imageLoader = imageLoader
    self.imageTransformer = imageTransformer
  }
  
  var fullname: String {
    "\(model.nameTitle). \(model.firstName) \(model.lastName)"
  }
  
  var email: String {
    "\(model.email)"
  }
  
  var memberSince: String {
    let isoDate = model.registrationDate
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
    "\(model.age) Years"
  }
  
  var birthday: String {
    let isoDate = model.birthDay
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
    "\(model.gender)"
  }
  
  var emergencyPhone: String {
    "\(model.phone)"
  }
  
  var address: String {
    "\(model.address.streetNumber) \(model.address.streetName), \(model.address.city), \(model.address.state), \(model.address.country)"
  }
  
  func loadImageData() {
    guard let userPictureURL = model.userPictureURL else {
      //TODO Handle sad path for invalid URL
      return
    }
    
    onImageLoadingStateChange?(true)
    
    task = imageLoader.loadImageData(from: userPictureURL) { [weak self] result in
      self?.handle(result)
    }
  }
  
  private func handle(_ result: UserImageDataLoader.Result) {
    if let image = (try? result.get()).flatMap(imageTransformer) {
      onImageLoad?(image)
    } else {
      //TODO Handle sad path for invalid image
    }
    onImageLoadingStateChange?(false)
  }
}
