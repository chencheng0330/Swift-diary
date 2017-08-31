//
//  StatusForwardTableViewCell.swift
//  微博
//
//  Created by 金亮齐 on 2017/8/29.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class StatusForwardTableViewCell: StatusTableViewCell {

    override var status: Status?{
        didSet{
            let name = status?.retweeted_status?.user?.name ?? ""
            let text = status?.retweeted_status?.text ?? ""
            forwardLabel.text = name + ":" + text
            
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        contentView.insertSubview(forwardButton, aboveSubview: pictureView)
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton)
        
        forwardButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.right.left.equalTo(footerView)
            make.bottom.equalTo(footerView.snp.top)
        }
        
        forwardLabel.snp.makeConstraints { (make) in
            make.top.equalTo(forwardButton).offset(10)
            make.left.equalTo(forwardButton).offset(10)
            make.right.equalTo(forwardButton).offset(-10)
        }
        
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(forwardLabel.snp.bottom).offset(10)
            make.left.equalTo(forwardLabel)
        }
    }
    
    
    private lazy var forwardLabel: UILabel = {
        let label = UILabel.createLabel(color: UIColor.darkGray, fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        return label
    }()
    
    private lazy var forwardButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
    
}
