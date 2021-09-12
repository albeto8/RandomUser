//
//  UserInfoViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation
import UserFeature
import Combine

public final class UserInfoViewModel<Image> {
  public typealias Observer<T> = (T) -> Void
  
  private let model: User
  private let imageLoader: (URL) -> AnyPublisher<Data, Error>
  private let imageTransformer: (Data) -> Image?
  private var cancellable: Cancellable?
  
  public var onImageLoad: Observer<Image>?
  var onImageLoadingStateChange: Observer<Bool>?
  
  public init(user: User, 
              imageLoader: @escaping (URL) -> AnyPublisher<Data, Error>, 
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
    
    cancellable = imageLoader(userPictureURL).sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        //TODO Handle sad path for invalid image
        print("Network failure!!!")
        
      case .finished: break
      }
    }, receiveValue: { [weak self] imageData in
      if let image = self?.imageTransformer(imageData) {
        self?.onImageLoad?(image)
      } else {
        //TODO Handle sad path for invalid image
      }
    })
  }
}
