//
//  ProfileUserMapper.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import Foundation

public final class ProfileUserMapper {  
  private struct Root: Decodable {
    private let results: [RemoteUser]
    
    private struct RemoteUser: Decodable {
      private let gender: String
      private let name: RemoteName
      private let location: RemoteLocation
      private let email: String
      private let dob: RemoteDob
      private let registered: RemoteRegistered
      private let phone, cell: String
      private let picture: RemotePicture
      
      private struct RemoteName: Decodable {
        let title: String
        let first: String
        let last: String
      }
      
      private struct RemoteDob: Decodable {
        let date: String
        let age: Int
      }
      
      private struct RemoteRegistered: Decodable {
        let date: String
      }
      
      private struct RemoteLocation: Decodable {
        let street: RemoteStreet
        let city: String
        let state: String
        let country: String
        let coordinates: RemoteCoordinates
      }
      
      private struct RemoteCoordinates: Decodable {
        let latitude: String
        let longitude: String
      }
      
      private struct RemoteStreet: Decodable {
        let number: Int
        let name: String
      }
      
      private struct RemotePicture: Decodable {
        let large: String
      }
      
      var user: User {
        return User(nameTitle: name.title, 
                    firstName: name.first, 
                    lastName: name.last, 
                    gender: gender, 
                    email: email, 
                    birthDay: dob.date, 
                    age: dob.age, 
                    phone: phone, 
                    cellPhone: cell, 
                    userPictureURL: URL(string: picture.large), 
                    registrationDate: registered.date, 
                    address: Address(streetNumber: location.street.number, 
                                     streetName: location.street.name, 
                                     city: location.city, 
                                     state: location.state, 
                                     country: location.country, 
                                     latitude: location.coordinates.latitude, 
                                     longitude: location.coordinates.longitude))
      }
    }
    
    var dto: User {
      return results.first!.user
    }
  }
  
  public static func map(data: Data) throws -> User {
    do {
      let root = try JSONDecoder().decode(Root.self, from: data)
      return root.dto
      
    } catch {
      throw error
    }    
  }
}
