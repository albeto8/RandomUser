//
//  ProfileUIComposer.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import UIKit

final class ProfileUIComposer {
  private init() {}
  
  static func controllerWith(userLoader: UserLoader) -> ProfileViewController {
    let profileViewModel = ProfileViewModel(loader: userLoader)
    let controller = ProfileViewController(profileViewModel: profileViewModel)
    
    return controller
  }
}
