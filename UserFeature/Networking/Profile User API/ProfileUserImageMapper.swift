//
//  ProfileUserImageMapper.swift
//  UserFeature
//
//  Created by Mario Alberto Barragán Espinosa on 11/09/21.
//

import Foundation

public final class ProfileUserImageMapper {
  public enum Error: Swift.Error {
    case invalidData
  }
  
  public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
    guard response.isOK, !data.isEmpty else {
      throw Error.invalidData
    }
    
    return data
  }
}

extension HTTPURLResponse {
  private static var OK_200: Int { return 200 }
  
  var isOK: Bool {
    return statusCode == HTTPURLResponse.OK_200
  }
}
