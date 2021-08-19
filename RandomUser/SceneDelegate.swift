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
    
    let client = URLSessionHTTPClient(session: .shared)
    let loader = RemoteUserLoader(url: URL(string: "https://randomuser.me/api/")!, client: client)
    
    let imageLoader = RemoteUserImageDataLoader(client: client)
    
    let controller = ProfileUIComposer.controllerWith(userLoader: loader, 
                                                      imageLoader: imageLoader)
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
  }
}

