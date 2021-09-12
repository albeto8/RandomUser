//
//  ProfileUIComposer.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import UIKit
import UserFeature
import Combine
import RandomUseriOS

final class ProfileUIComposer {
  private init() {}
  
  static func controllerWith(userLoader: @escaping () -> AnyPublisher<User, Error>, 
                             imageLoader: @escaping (URL) -> AnyPublisher<Data, Error>) -> ProfileViewController {
    let profileViewModel = ProfileViewModel(loader: userLoader)
    let controller = ProfileViewController(profileViewModel: profileViewModel)
    
    profileViewModel.onFetch = { user in
      let userInfoViewModel = UserInfoViewModel<UIImage>(user: user, 
                                                         imageLoader: imageLoader,
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
