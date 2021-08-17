//
//  SceneDelegate.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let controller = ProfileViewController()
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
  }
}

