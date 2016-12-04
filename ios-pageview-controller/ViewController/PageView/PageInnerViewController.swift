//
//  PageInnerViewController.swift
//  PageViewControllerDemo
//
//  Created by Kushida　Eiji on 2016/08/10.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

private extension Selector {
    static let singleTap = #selector(PageInnerViewController.singleTap(_:))
    static let doubleTap = #selector(PageInnerViewController.doubleTap(_:))
}

final class PageInnerViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    var pageIndex = 0
    var filePath = ""
    fileprivate var isHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addEventListener()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureImageView()
    }

    //Level2
    fileprivate func setup() {
        setupScrollView()
        setupImageView(filePath: filePath)
    }
    
    fileprivate func addEventListener() {
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action:Selector.singleTap)
        singleTapGesture.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action:Selector.doubleTap)
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(doubleTapGesture)
        singleTapGesture.require(toFail: doubleTapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    fileprivate func configureImageView() {
        scrollView.zoomScale = 1.0
        scrollView.isScrollEnabled = true
    }

    //Level3
    fileprivate func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
    }
    
    fileprivate func setupImageView(filePath: String) {
        imageView.image = UIImage(named: filePath)
        imageView.roundCornersForAspectFit(5.0)
    }

    func singleTap(_ gesture: UITapGestureRecognizer) -> Void {

        isHidden = !isHidden
        self.navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
    
    func doubleTap(_ gesture: UITapGestureRecognizer) -> Void {
        
        if ( self.scrollView.zoomScale < 1.9 ) {
            let newScale:CGFloat = scrollView.zoomScale * 2.0
            let zoomRect:CGRect = self.zoomRectForScale(newScale,
                                                        center: gesture.location(in: gesture.view))
            scrollView.zoom(to: zoomRect, animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
}

//MARK:- UIScrollViewDelegate
extension PageInnerViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func zoomRectForScale(_ scale:CGFloat, center: CGPoint) -> CGRect{
        var zoomRect = CGRect()
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width = scrollView.frame.size.width / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        return zoomRect
    }
}
