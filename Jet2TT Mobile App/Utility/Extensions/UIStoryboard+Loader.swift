//
//  UIStoryboard+Loader.swift
//  RajeshSampleProject
//
//  Created by RajeshDeshmukh on 26/04/20.
//  Copyright © 2020 Yogita Bansode. All rights reserved.
//


import UIKit

extension AppConstant {
    /// Storyboard file names
    struct Storyboard {
        static let kMainStoryboard = "Main"
    }
}

// MARK:- load UIStoryboard
extension UIStoryboard {
    static func loadViewController(storyBoardName: String,
                                   SBVCIdentifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: SBVCIdentifier)
    }
}

// MARK:- load view controller from UIStoryboard
extension UIStoryboard {
   
  static func loadLandingVC() -> LandingVC {
      return loadViewController(storyBoardName: AppConstant.Storyboard.kMainStoryboard,
                                SBVCIdentifier: LandingVC.identifier) as? LandingVC ?? LandingVC()
  }

}

