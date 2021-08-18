//
//  ProfileUserLoader.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public final class RemoteUserLoader: UserLoader {
  private let url: URL
  private let client: HTTPClient
  
  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
  
  public typealias Result = UserLoader.Result
  
  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { result in
      switch result {
      case .success((let data, _)):
        guard let mappedUser = try? ProfileUserMapper.map(data: data) else {
          completion(.failure(ProfileUserMapper.Error.invalidData))
          return
        }
        
        completion(.success(mappedUser))
      
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
