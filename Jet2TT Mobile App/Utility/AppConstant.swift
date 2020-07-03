//
//  AppConstant.swift
//  Jet2TT Mobile App
//
//  Created by RajeshDeshmukh on 01/07/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class AppConstant {
    
    ///  List of ApiURLS
    struct ApiURLS {
        static let aboutArticle = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?page=1&limit=10"
    }
    
    ///  List of literal Strings
    struct LiteralString {
        static let navigationBarTitle = "Articles"
        static let errorTitle = "Error"
        static let errorMsg = "Failed to load data from server."
        static let okBtn = "OK"
        static let offlineMsg = "The Internet connection appears to be offline."
        static let loadCacheDataMsg = "The Internet connection appears to be offline & showing Articles from local cache."
        static let NoResultFoundMsg = "No articles found in local cache."
        
    }
    
    ///  List of  color codes
    struct AppColor {
        static let kColor_black = UIColor.black
        static let kColor_DarkGray = UIColor.darkGray
    }
    
    ///  List of fonts
    struct AppFonts {
        static let kboldSystemFont16 = UIFont.boldSystemFont(ofSize: 16)
        static let ksystemFont14 = UIFont.systemFont(ofSize: 14)
    }
    
    ///  List of Images
     struct AppImage {
       static let placeholder = "placeholder"
     }
    
}
