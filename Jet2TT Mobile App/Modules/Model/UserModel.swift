//
//  UserModel.swift
//  Jet2TT Mobile App
//
//  Created by RajeshDeshmukh on 01/07/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

struct UserModel : Codable {
    
    let id : String?
    let blogId : String?
    var createdAt : String?
    let name : String?
    let avatar : String?
    let lastname : String?
    let city : String?
    let designation : String?
    let about : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case name = "name"
        case avatar = "avatar"
        case lastname = "lastname"
        case city = "city"
        case designation = "designation"
        case about = "about"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        about = try values.decodeIfPresent(String.self, forKey: .about)
        let createdAtStr = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdAt = self.differenceOfDate(date: createdAtStr ?? "")
    }
    
    func differenceOfDate(date: String) -> String {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let formattedStartDate = formatter.date(from: date) else {
            return ""
        }
        
        let currentDateString = formatter.string(from: Date())
        guard let formattedCurrentDate = formatter.date(from: currentDateString) else {
            return ""
        }
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day,.hour,.minute,.second]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
       
        let differenceOf2Dates = dateComponentsFormatter.string(from: formattedStartDate, to: formattedCurrentDate)
        return differenceOf2Dates ?? ""
    }
}
