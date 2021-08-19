//
//  ProfileUIComposer.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import UIKit

final class ProfileUIComposer {
  private init() {}
  
  static func controllerWith(userLoader: UserLoader, 
                             imageLoader: UserImageDataLoader) -> ProfileViewController {
    let profileViewModel = ProfileViewModel(loader: MainQueueDispatchDecorator(decoratee: userLoader))
    let controller = ProfileViewController(profileViewModel: profileViewModel)
    
    profileViewModel.onFetch = { user in
      let userInfoViewModel = UserInfoViewModel<UIImage>(user: user, 
                                                         imageLoader: imageLoader,
                                                         imageTransformer: UIImage.init)
      controller.display(userInfoViewModel)
      
      
    }
    
    return controller
  }
}
