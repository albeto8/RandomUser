//
//  Date+Extensions.swift
//  RandomUseriOS
//
//  Created by Mario Alberto Barragán Espinosa on 20/08/21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
  
  static func parseDate(dateString: String, outputFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    if let date = dateFormatter.date(from: dateString) {
      let formate = date.getFormattedDate(format: outputFormat)
      
      return "\(formate)"
    }
    
    return ""
  }
}
