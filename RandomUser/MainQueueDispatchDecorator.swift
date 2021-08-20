//
//  MainQueueDispatchDecorator.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import Foundation
import UserFeature

final class MainQueueDispatchDecorator<T> {
  private let decoratee: T
  
  init(decoratee: T) {
    self.decoratee = decoratee
  }
  
  func dispatch(completion: @escaping () -> Void) {
    guard Thread.isMainThread else {
      return DispatchQueue.main.async(execute: completion)
    }
    
    completion()
  }
}

extension MainQueueDispatchDecorator: UserLoader where T == UserLoader {
  func load(completion: @escaping (UserLoader.Result) -> Void) {
    decoratee.load { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}

extension MainQueueDispatchDecorator: UserImageDataLoader where T == UserImageDataLoader {
  func loadImageData(from url: URL, completion: @escaping (UserImageDataLoader.Result) -> Void) -> UserImageDataLoaderTask {
    decoratee.loadImageData(from: url) { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}
