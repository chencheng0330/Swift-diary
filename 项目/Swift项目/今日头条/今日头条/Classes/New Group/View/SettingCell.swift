//
//  SettingCell.swift
//  今日头条
//
//  Created by 金亮齐 on 2017/9/28.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    var setting: SettingModel! {
        didSet {
            titleLabel.text = setting.title
            subtitleLabel.text = setting.subtitle
            rightTitleLabel.text = setting.rightTitle
            arrowImageView.isHidden = setting.isHiddenArraw!
            switchView.isHidden = setting.isHiddenSwitch!
            lineView.isHidden = setting.isHiddenLine!
            rightTitleLabel.isHidden = setting.isHiddenRightTitle!
            if setting.subtitle!.characters.count > 0 {
                subtitleHeight.constant = self.height * 0.5
                self.layoutIfNeeded()
            }
        }
    }
    
    @IBOutlet weak var subtitleHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
