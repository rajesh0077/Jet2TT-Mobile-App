//
//  ArticlesCell.swift
//  Jet2TT Mobile App
//
//  Created by RajeshDeshmukh on 01/07/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class ArticlesCell: UITableViewCell {
    /// Private Constants
    private struct Constant {
      static let borderWidth: CGFloat = 0.1
      static let cornerRadius: CGFloat = 24
    }
    
    /// IBOutlet
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDesignation: UILabel!
    @IBOutlet weak var lblPostUploadTime: UILabel!
    @IBOutlet weak var lblArticleContent: UILabel!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleUrl: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var imgUserProfilePic: UIImageView!
    @IBOutlet weak var imgMediaPic: UIImageView!
    
    /// Computated property to set tableview cell data
    var rowCellModel: ArticlesModel? {
        didSet {
            guard let model = rowCellModel else {return}
            
            if let name = model.user?[0].name {
                lblUserName.text = name
            }
            if let designation = model.user?[0].designation {
                lblUserDesignation.text = designation
            }
            if let createdAt = model.user?[0].createdAt {
                lblPostUploadTime.text = createdAt
            }
            if let href = model.user?[0].avatar {
                imgUserProfilePic.downloaded(from: href)
            }
            if let href = model.media?[0].image {
                imgMediaPic.downloaded(from: href)
            }
            if let content = model.content {
                lblArticleContent.text = content
            }
            if let title =  model.media?[0].title {
                lblArticleTitle.text = title
            }
            if let title =  model.media?[0].url {
                lblArticleUrl.text = title
            }
            if let likes = model.likes {
                lblLikeCount.text = String(likes) + " Likes"
            }
            if let comments = model.comments {
                lblCommentCount.text = String(comments)  + " Comments"
            }
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func initializeLocalization() {
        lblUserName.text = ""
        lblUserDesignation.text = ""
        lblPostUploadTime.text = ""
        lblArticleContent.text = ""
        lblArticleTitle.text = ""
        lblArticleUrl.text = ""
        lblLikeCount.text = ""
        lblCommentCount.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initializeLocalization()
        setCircularImage()
    }
    
    func setCircularImage()  {
        imgUserProfilePic.layer.cornerRadius = ArticlesCell.Constant.cornerRadius
        imgUserProfilePic.clipsToBounds = true
        imgUserProfilePic.layer.masksToBounds = true
        imgUserProfilePic.layer.borderWidth = ArticlesCell.Constant.borderWidth
        imgUserProfilePic.layer.borderColor = AppConstant.AppColor.kColor_DarkGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

