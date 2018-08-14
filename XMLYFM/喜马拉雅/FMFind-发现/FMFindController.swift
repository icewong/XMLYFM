//
//  FMFindController.swift
//  XMLYFM
//
//  Created by Domo on 2018/7/30.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class FMFindController: UIViewController {
    //Mark:- headerView
    private lazy var headerView:FMFindHeaderView = {
        let view = FMFindHeaderView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:190))
        return view
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        let oneVc = FindAttentionController()
        let twoVc = FindRecommendController()
        let threeVc = FindDudController()
        return [oneVc, twoVc, threeVc]
    }()
    
    private lazy var titles: [String] = {
        return ["关注动态", "推荐动态", "趣配音"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 64, width: YYScreenWidth, height: YYScreenHeigth-64), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
//                advancedManager.hoverY = 64
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
    }

    deinit {
        print("FMFindController < --> deinit")
    }
}

extension FMFindController : LTAdvancedScrollViewDelegate {
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        //        print("offset --> ", offsetY)
    }
}

