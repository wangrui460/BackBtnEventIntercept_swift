# BackBtnEventIntercept_swift
系统返回按钮事件拦截
[OC 版本](https://github.com/wangrui460/BackBtnEventIntercept)

- **主要实现原理**

<pre><code>
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
</code></pre>

- **如何使用**

<pre><code>
// 如果需要拦截系统返回按钮就重写该方法返回 false
override func currentViewControllerShouldPop() -> Bool {
    return false
}
</code></pre>

- **如何禁用系统👉右滑返回手势**

<pre><code>
override func viewWillAppear(_ animated: Bool) 
{
    super.viewWillAppear(animated)
    // 为当前控制器禁用👉右滑返回手势
    if (navigationController?.responds(to: NSSelectorFromString("interactivePopGestureRecognizer")))! {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

override func viewWillDisappear(_ animated: Bool) 
{
    super.viewWillDisappear(animated)
    // 为其他控制器开启👉右滑返回手势
    if (navigationController?.responds(to: NSSelectorFromString("interactivePopGestureRecognizer")))! {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}
</code></pre>


你觉得对你有所帮助的话，请献上宝贵的Star！！！ 不胜感激！！！
