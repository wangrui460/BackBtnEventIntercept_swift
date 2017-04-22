//
//  ViewController.swift
//  BackBtnEventIntercept_swift
//
//  Created by wangrui on 2017/4/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 为当前控制器禁用👉右滑返回手势
        if (navigationController?.responds(to: NSSelectorFromString("interactivePopGestureRecognizer")))! {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 为其他控制器开启👉右滑返回手势
        if (navigationController?.responds(to: NSSelectorFromString("interactivePopGestureRecognizer")))! {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    // 如果需要拦截系统返回按钮就重写该方法返回 false
    override func currentViewControllerShouldPop() -> Bool {
        return false
    }
}

