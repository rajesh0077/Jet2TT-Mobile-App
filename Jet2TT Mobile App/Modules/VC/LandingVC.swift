//
//  LandingVC.swift
//  Jet2TT Mobile App
//
//  Created by RajeshDeshmukh on 02/07/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {
    
    /// Private Constants
    private struct Constant {
        static let estimatedRowHeight: CGFloat = 301
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    /// Variables
    lazy var viewModelObj = {
        /// here is the use of constructor’s dependency injection
        return ArticleViewModel(landingVCObj: self)
    }()
    
    /// IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModelObj.getNavigationTitle()
        configureTableView()
        addRefreshButton()
      callAPI()
        //testDate()
    }
    func testDate()  {
        let input = "2020-04-16T20:17:42.437Z"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: input) {
            print(date)
        }
        
        
    }
    deinit {
        print("perform the deinitialization")
    }
    
}

extension LandingVC {
    
    /// Function to fetch API Data
    func callAPI() {
        viewModelObj.fetchArticles()
    }
    
    /// API Response Received
    /// - parameter Bool: is success from API
    /// - parameter AnyObject: instance of exception if any
    func didReceiveApiResponse(isSuccess: Bool, exception: AnyObject?) {
        
        if isSuccess {
            print(isSuccess)
            DispatchQueue.main.async {
                if self.viewModelObj.getTotalNumberOfArticles() > 0 {
                    self.tableView.reloadData()
                }
            }
        } else {
            DispatchQueue.main.async {
                let errorDesc = exception?.localizedDescription ?? AppConstant.LiteralString.errorMsg
                let isOffline = self.viewModelObj.isOffline(ErrorStr: errorDesc)
                if isOffline {
                    self.showAlert(title: AppConstant.LiteralString.errorTitle,
                    message : AppConstant.LiteralString.loadCacheDataMsg,
                    actionTitle : AppConstant.LiteralString.okBtn)
                } else {
                    self.showAlert(title: AppConstant.LiteralString.errorTitle,
                    message : errorDesc,
                    actionTitle : AppConstant.LiteralString.okBtn)
                }
            }
        }
    }

}

// MARK: - TableView Utility Methods

extension LandingVC: UITableViewDataSource {
    
    /// Function to configure TableView
    func configureTableView() {
        if let tableView = self.tableView {
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = LandingVC.Constant.estimatedRowHeight
            registerTableCell()
            
            ///Eliminate extra separators below UITableView
            tableView.tableFooterView = UIView()
        }
    }
    
    /// Function to  register table view cell
    func registerTableCell () {
        if let tableView = self.tableView {
            tableView.register(cells: [ArticlesCell.self])
        }
    }
    
    /// Function to creation cell  and it's configuration
    /// - parameter indexPath: IndexPath for cell
    /// - ReturnS: instance of ImageTableViewCell
    
    func getArticleCellFor(indexPath: IndexPath) -> ArticlesCell? {
        let cell = tableView?.dequeueReusableCell(withIdentifier: ArticlesCell.identifier,
                                                  for: indexPath) as? ArticlesCell
        /// set table view cell data
        cell?.rowCellModel = viewModelObj.getPerticularArticleAtIndexPath(indexPath: indexPath)
        
        return cell
    }
    
}

// MARK: -  TableView Data Source

extension LandingVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelObj.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelObj.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getArticleCellFor(indexPath: indexPath) ?? UITableViewCell()
    }
    
}

// MARK: - Helper Methods

extension LandingVC {
    
    /// Function to displays alertview controller
    /// - parameter String: title for alert
    /// - parameter String: message for alert
    /// - parameter String: actionbtnTitle for alert
    func showAlert(title : String , message : String , actionTitle : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func addRefreshButton() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refresh() {
        callAPI()
    }
    
}

