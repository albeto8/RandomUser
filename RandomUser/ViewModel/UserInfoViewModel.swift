//
//  UserInfoViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation
import UserFeature

public final class UserInfoViewModel<Image> {
  public typealias Observer<T> = (T) -> Void
  
  private var task: UserImageDataLoaderTask?
  private let model: User
  private let imageLoader: UserImageDataLoader
  private let imageTransformer: (Data) -> Image?
  
  public var onImageLoad: Observer<Image>?
  var onImageLoadingStateChange: Observer<Bool>?
  
  public init(user: User, 
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
    let parsedDate = Date.parseDate(dateString: model.registrationDate, 
                               outputFormat: "yyyy")
    return "Member since \(parsedDate)"
  }
  
  var age: String {
    "\(model.age) Years"
  }
  
  var birthday: String {    
    let parsedDate = Date.parseDate(dateString: model.birthDay, 
                               outputFormat: "MM/dd")
    return "\(parsedDate)"
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
