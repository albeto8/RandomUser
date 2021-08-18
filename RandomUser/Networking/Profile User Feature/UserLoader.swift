//
//  UserLoader.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation
 
public protocol UserLoader {
  typealias Result = Swift.Result<User, Swift.Error>
  
  func load(completion: @escaping (Result) -> Void)
}
