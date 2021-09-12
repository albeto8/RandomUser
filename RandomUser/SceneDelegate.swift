//
//  SceneDelegate.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit
import UserFeature
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  private lazy var httpClient: HTTPClient = {
    URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
  }()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let client = URLSessionHTTPClient(session: .shared)
        
    let controller = ProfileUIComposer.controllerWith(
      userLoader: makeRemoteUserLoader, 
      imageLoader: makeRemoteUserImageLoader)
    
    window = UIWindow(windowScene: scene)
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
  }
  
  private func makeRemoteUserLoader() -> AnyPublisher<User, Error> {
    let url = URL(string: "https://randomuser.me/api/")!
    return httpClient
      .getPublisher(url: url)
      .dispatchOnMainQueue()
      .tryMap(ProfileUserMapper.map)
      .eraseToAnyPublisher()
  }
  
  private func makeRemoteUserImageLoader(url: URL) -> AnyPublisher<Data, Error> {
    return httpClient
      .getPublisher(url: url)
      .dispatchOnMainQueue()
      .tryMap(ProfileUserImageMapper.map)
      .eraseToAnyPublisher()
  }
}

