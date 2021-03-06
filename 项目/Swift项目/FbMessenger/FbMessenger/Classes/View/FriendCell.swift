//
//  FriendCell.swift
//  FbMessenger
//
//  Created by 金亮齐 on 2017/11/22.
//  Copyright © 2017年 金亮齐. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    var message: Message? {
        didSet{
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            messageLabel.text = message?.text
            if let date = message?.date{
                let dateFormate = NSDateFormatter()
                dateFormate.dateFormat = "h:mm a"
                timeLabel.text = dateFormate.stringFromDate(date)
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.5,alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckeroery"
        label.font = UIFont.systemFontOfSize(18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your frieds message and something else..."
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = .Right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func setupViews(){
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "headImage")
        hasReadImageView.image = UIImage(named: "headImage")
        
        addConstraintsWithFormat("H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat("V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView,attribute: .CenterY,relatedBy: .Equal,toItem: self,attribute: .CenterY,multiplier: 1,constant: 0))
        
        addConstraintsWithFormat("H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
    }
    
    private func setupContainerView(){
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintsWithFormat("H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat("V:[v0(50)]", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView,attribute: .CenterY,relatedBy: .Equal,toItem: self,attribute: .CenterY,multiplier: 1,constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraintsWithFormat("H:|[v0][v1(80)]-12-|", views: nameLabel,timeLabel)
        containerView.addConstraintsWithFormat("V:|[v0][v1(24)]|", views: nameLabel,messageLabel)
        containerView.addConstraintsWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: messageLabel,hasReadImageView)
        containerView.addConstraintsWithFormat("V:|[v0(24)]", views: timeLabel)
        containerView.addConstraintsWithFormat("V:[v0(20)]|", views: hasReadImageView)
    }
}
