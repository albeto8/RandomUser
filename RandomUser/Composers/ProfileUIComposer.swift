//
//  ProfileUIComposer.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import UIKit
import UserFeature
import RandomUseriOS

final class ProfileUIComposer {
  private init() {}
  
  static func controllerWith(userLoader: UserLoader, 
                             imageLoader: UserImageDataLoader) -> ProfileViewController {
    let profileViewModel = ProfileViewModel(loader: MainQueueDispatchDecorator(decoratee: userLoader))
    let controller = ProfileViewController(profileViewModel: profileViewModel)
    
    profileViewModel.onFetch = { user in
      let userInfoViewModel = UserInfoViewModel<UIImage>(user: user, 
                                                         imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader),
                                                         imageTransformer: UIImage.init)
      controller.display(userInfoViewModel)
      controller.loadUserImage()
            
      userInfoViewModel.onImageLoad = { image in
        controller.display(userImage: image)
      }
      
    }
    
    return controller
  }
}
