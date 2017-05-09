//
//  PageViewController.swift
//  PageViewControllerDemo
//
//  Created by Kushida　Eiji on 2016/08/10.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

class PageViewController : UIViewController {

    fileprivate var pageViewController:UIPageViewController!
    fileprivate var imageFiles = ["image01.jpeg","image02.jpeg","image03.jpeg","image04.jpeg","image05.jpeg"]
    fileprivate var pageIndex = 0
    fileprivate var dataSource = PageViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func scrollToPage(_ pageIndex: Int) {
        if let currentViewController = dataSource.viewControllerAtIndex(pageIndex) {
            
            if let pageViewController = pageViewController {
                pageViewController.setViewControllers([currentViewController],
                                                      direction: .forward, animated: false, completion: nil)
            }
        }
    }

    fileprivate func setup() {

        setupNavigationBar()
        setupDataSource(imageFiles: imageFiles)
        setupPageView()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.hidesBarsOnTap = true
    }
    
    fileprivate func setupDataSource(imageFiles: [String]) {
        dataSource.setupImageFile(imageFiles: imageFiles)
    }
    
    fileprivate func setupPageView() {
        if let startingViewController = dataSource.viewControllerAtIndex(0) {
            
            pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: [UIPageViewControllerOptionInterPageSpacingKey : 20])
            
            if let pageViewController = pageViewController {
                pageViewController.dataSource = dataSource
                pageViewController.delegate = self
                pageViewController.setViewControllers([startingViewController],
                                                      direction: .forward,
                                                      animated: false,
                                                      completion: {done in})
                pageViewController.view.frame = self.view.frame
                addChildViewController(pageViewController)
                self.view.addSubview(pageViewController.view)
            }
        }
    }
}

//MARK:-UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        if let vc = pageViewController.viewControllers?.first as? PageInnerViewController {
            print("画面遷移直前: \(vc.pageIndex)")
        }

        print("willTransitionTo pendingViewControllers: \(pendingViewControllers) ")
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {

        if let vc = pageViewController.viewControllers?.first as? PageInnerViewController {
            print(vc.pageIndex)
        }
    }
}
