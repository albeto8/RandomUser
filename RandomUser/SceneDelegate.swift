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
    
    let client = URLSessionHTTPClient(session: .shared)
    let loader = RemoteUserLoader(url: URL(string: "https://randomuser.me/api/")!, client: client)
    loader.load { result in
      print("result: \(result)")
    }
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
  }
}

