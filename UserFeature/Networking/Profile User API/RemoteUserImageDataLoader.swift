//
//  RemoteUserImageDataLoader.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import Foundation

public final class RemoteUserImageDataLoader: UserImageDataLoader {
  private let client: HTTPClient
  
  public init(client: HTTPClient) {
    self.client = client
  }
  
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  private final class HTTPClientTaskWrapper: UserImageDataLoaderTask {
    private var completion: ((UserImageDataLoader.Result) -> Void)?
    
    var wrapped: HTTPClientTask?
    
    init(_ completion: @escaping (UserImageDataLoader.Result) -> Void) {
      self.completion = completion
    }
    
    func complete(with result: UserImageDataLoader.Result) {
      completion?(result)
    }
    
    func cancel() {
      preventFurtherCompletions()
      wrapped?.cancel()
    }
    
    private func preventFurtherCompletions() {
      completion = nil
    }
  }
  
  public func loadImageData(from url: URL, completion: @escaping (UserImageDataLoader.Result) -> Void) -> UserImageDataLoaderTask {
    let task = HTTPClientTaskWrapper(completion)
    task.wrapped = client.get(from: url) { [weak self] result in
      guard self != nil else { return }
      task.complete(with: result
                      .mapError { _ in Error.connectivity }
                      .flatMap { (data, response) in
                        let isValidResponse = response.isOK && !data.isEmpty
                        return isValidResponse ? .success(data) : .failure(Error.invalidData)
                      })
    }
    return task
  }
}

extension HTTPURLResponse {
  private static var OK_200: Int { return 200 }
  
  var isOK: Bool {
    return statusCode == HTTPURLResponse.OK_200
  }
}
