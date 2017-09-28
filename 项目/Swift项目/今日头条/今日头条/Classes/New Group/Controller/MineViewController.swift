//
//  MineViewController.swift
//  今日头条
//
//  Created by 金亮齐 on 2017/9/27.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    fileprivate var sections = [AnyObject]()
    fileprivate var concerns = [MyConcern]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestDate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 头部视图
    fileprivate lazy var noLoginHeaderView: NoLoginHeaderView = {
        let noLoginHeaderView = NoLoginHeaderView.headerView()
        return noLoginHeaderView
    }()

}



extension MineViewController {
    
    fileprivate func setupUI() {
        self.title = "个人中心";
        // 设置标题
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        /// 设置 tableView 属性
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.tableHeaderView = noLoginHeaderView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: String(describing: MineFirstSectionCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MineFirstSectionCell.self))
        tableView.register(UINib(nibName: String(describing: MineOtherCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MineOtherCell.self))
        
    }
    
}

extension MineViewController {
    fileprivate func requestDate(){
        NetworkTool.loadMineCellData { (sectionArray) in
            let dict = ["text": "我的关注", "grey_text": ""]
            let myConcern = MineCellModel(dict: dict as [String : AnyObject])
            var myConcerns = [MineCellModel]()
            myConcerns.append(myConcern)
            self.sections.append(myConcerns as AnyObject)
            self.sections += sectionArray
            self.tableView.reloadData()
            NetworkTool.loadMyFollow { (concerns) in
                self.concerns = concerns
                if concerns.count != 0 {
                    let indexSet = IndexSet(integer: 0)
                    self.tableView.reloadSections(indexSet, with: .automatic)
                }
            }
        }
    }
}

// MARK: - // MARK: - Table view data source
extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 1 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MineFirstSectionCell.self)) as! MineFirstSectionCell
            let section = sections[0] as! [AnyObject]
            let mineCellModel = section[0]  as! MineCellModel
            cell.selectionStyle = .none
            cell.delegate = self
            cell.mineCellModel = mineCellModel
            if concerns.count == 0 || concerns.count == 1 {
                cell.collectionView.isHidden = true
            }
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.concerns = concerns
                cell.collectionView.isHidden = false
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MineOtherCell.self)) as! MineOtherCell
        let section = sections[indexPath.section] as! [AnyObject]
        let mineCellModel = section[indexPath.row]  as! MineCellModel
        cell.mineCellModel = mineCellModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 { // 我的关注
//            let myConcernVC = MyConcernController()
//            myConcernVC.myConcerns = concerns
//            navigationController?.pushViewController(myConcernVC, animated: true)
        } else if indexPath.section == 1 {
            // 消息通知
        } else if indexPath.section == 2 {
            // 头条商城，京东特供
        }  else if indexPath.section == 3 {
             // 我要爆料，用户反馈，系统设置
            if indexPath.row == 2 { // 系统设置
                self.navigationController?.pushViewController(SettingViewController(), animated: true)
            }
        }
    }
    
    // MARK: - UIScrollViewDelagate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY < 0 {
            let totalOffset = kMineHeaderViewHieght + abs(offsetY)
            let f = totalOffset / kMineHeaderViewHieght
            noLoginHeaderView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MineViewController: MineFirstSectionCellDelegate {

    /// 点击了 第一个 cell 的标题
    func mineFirstSectionCellTitleButtonClicked() {
//        let myConcernVC = MyConcernController()
//        myConcernVC.myConcerns = concerns
//        navigationController?.pushViewController(myConcernVC, animated: true)
    }
    /// 点击了第几个关注
    func mineFirstSectionCellDidSelected(myConcern: MyConcern) {
        let followDetail = FollowDetailViewController()
        followDetail.userid = myConcern.userid ?? 0
        navigationController?.pushViewController(followDetail, animated: true)
    }
}
