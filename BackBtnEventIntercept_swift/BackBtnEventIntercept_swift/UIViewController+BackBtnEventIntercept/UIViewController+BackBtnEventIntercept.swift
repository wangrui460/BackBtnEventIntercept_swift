//
//  UIViewController+BackBtnEventIntercept.swift
//  BackBtnEventIntercept_swift
//
//  Created by wangrui on 2017/4/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

// 如果你想使用的optional方法，你必须用@objc标记您的protocol
public protocol ShouldPopDelegate
{
    func currentViewControllerShouldPop() -> Bool
}

extension UIViewController: ShouldPopDelegate
{
    public func currentViewControllerShouldPop() -> Bool {
        return true
    }
}

extension UINavigationController: UINavigationBarDelegate
{
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool
    {
        var shouldPop = true
        // 看一下当前控制器有没有实现代理方法 currentViewControllerShouldPop
        // 如果实现了，根据当前控制器的代理方法的返回值决定
        // 没过没有实现 shouldPop = YES
        let currentVC = self.topViewController
//        if (currentVC?.responds(to: #selector(currentViewControllerShouldPop)))! {
            shouldPop = (currentVC?.currentViewControllerShouldPop())!
//        }
        
        if (shouldPop == true)
        {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
            // 这里要return, 否则这个方法将会被再次调用
            return true
        }
        else
        {
            // 让系统backIndicator 按钮透明度恢复为1
            for subview in navigationBar.subviews
            {
                if (0.0 < subview.alpha && subview.alpha < 1.0) {
                    UIView.animate(withDuration: 0.25, animations: { 
                        subview.alpha = 1.0
                    })
                }
            }
            return false
        }
    }
}
