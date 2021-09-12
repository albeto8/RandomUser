//
//  ProfileViewModel.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 19/08/21.
//

import Foundation
import UserFeature
import Combine

public final class ProfileViewModel {
  private let loader: () -> AnyPublisher<User, Error>
  private var cancellable: Cancellable?
  
  public init(loader: @escaping () -> AnyPublisher<User, Error>) {
    self.loader = loader
  }
  
  public var onFetch: ((User) -> Void)?
  
  public func fetch() {
    cancellable = loader()
      .sink(receiveCompletion: { completion in
      switch completion {
      case .failure:
        // TODO: Handle error
        print("Network failure!!!")
        
      case .finished: break
      }
    }, receiveValue: { [weak self] user in
      self?.onFetch?(user)
    })
  }
}
