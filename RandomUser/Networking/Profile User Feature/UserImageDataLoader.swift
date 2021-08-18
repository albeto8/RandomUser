//
//  UserImageDataLoader.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public protocol ImageDataLoaderTask {
  func cancel()
}

public protocol UserImageDataLoader {
  typealias Result = Swift.Result<Data, Error>
  
  func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> ImageDataLoaderTask
}
