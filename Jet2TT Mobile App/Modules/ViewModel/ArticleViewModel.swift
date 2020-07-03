//
//  ArticleViewModel.swift
//  Jet2TT Mobile App
//
//  Created by RajeshDeshmukh on 01/07/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    weak var landingVCObj: LandingVC?
    var displayAboutArticles: [ArticlesModel]?
   
    init() {
    }
    
    init(landingVCObj: LandingVC) {
        self.landingVCObj = landingVCObj
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return getTotalNumberOfArticles()
    }
    
    func getTotalNumberOfArticles() -> Int {
        return displayAboutArticles?.count ?? 0
    }
    
    func getNavigationTitle() -> String {
        return AppConstant.LiteralString.navigationBarTitle
    }
    
    func getPerticularArticleAtIndexPath(indexPath: IndexPath) -> ArticlesModel? {
        return displayAboutArticles?[indexPath.row]
    }
    
    ///  function to fetch API Data by given URL
    func fetchArticles() {
        let urlStr = AppConstant.ApiURLS.aboutArticle
        
        /// Actual API Call using Network Manager
        NetworkManager.shared.callAPI(withURLStr: urlStr, onCompletion: {(data, error) in
            
            guard let data = data else {
                self.landingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
                return
            }
            
            let jsonStr = String(decoding: data, as: UTF8.self)
            print(jsonStr)
            
            let jsonDecoder = JSONDecoder()
            do {
                self.displayAboutArticles = try jsonDecoder.decode([ArticlesModel].self, from: data)
                self.landingVCObj?.didReceiveApiResponse(isSuccess: true, exception: error as AnyObject?)
            } catch {
                print(error.localizedDescription)
                self.landingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
            }
        })
    }
    
    func isOffline(ErrorStr: String) -> Bool {
        let isOffline = AppConstant.LiteralString.offlineMsg == ErrorStr ? true: false
        return isOffline
    }
}
