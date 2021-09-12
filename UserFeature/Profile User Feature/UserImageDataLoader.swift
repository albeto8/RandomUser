//
//  UserImageDataLoader.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public protocol UserImageDataLoader {  
  func loadImageData(from url: URL) throws -> Data
}
