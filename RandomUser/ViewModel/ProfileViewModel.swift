//
//  ProfileViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import Foundation
import UserFeature

final class ProfileViewModel {
  private let loader: UserLoader
  
  init(loader: UserLoader) {
    self.loader = loader
  }
  
  var onFetch: ((User) -> Void)?
  
  func fetch() {
    loader.load { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        self.onFetch?(user)
        
      case .failure(let error):
        print("Networking Error!! \(error)")
    }
    }
  }
}
