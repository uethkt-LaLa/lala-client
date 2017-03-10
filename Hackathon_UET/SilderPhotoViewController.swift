//
//  SilderPhotoViewController.swift
//  KiddyStory
//
//  Created by Anh Tuan on 3/2/17.
//  Copyright © 2017 QTS M002. All rights reserved.
//

import UIKit

class SilderPhotoViewController: UIViewController {
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var sliderView : UIView!
    var pageViewController: UIPageViewController!
    var listPhotoItem = [String]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
//        lblTitle.text = listPhotoItem[currentIndex].post["title"] as! String
        
        let initalViewController = viewControllerAtIndex(index: currentIndex)
        
        self.pageViewController.setViewControllers([initalViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        self.addChildViewController(pageViewController)
        let width = self.sliderView.frame.width
        let height = self.sliderView.frame.height
        pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        
        sliderView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //pageViewController.view.frame.width = self.sliderView.frame.width
    }
    override func viewDidLayoutSubviews() {
        let width = self.sliderView.frame.width
        let height = self.sliderView.frame.height
        pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> DisplayPhotoViewController {
        let childViewController = DisplayPhotoViewController(nibName: "DisplayPhotoViewController", bundle: nil)
        childViewController.imgObj = listPhotoItem[index]
        
        return childViewController
    }
    
    @IBAction func btnBackDidTouch(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func btnMoreTouchUp(_ sender : UIButton){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "DetailPostVC") as! DetailPostVC
//        let obj = listPhotoItem[currentIndex]
//        vc.allPhotoObj = obj
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
extension SilderPhotoViewController : UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if currentIndex == self.listPhotoItem.count - 1 {
            return nil
        }
        
        currentIndex = (currentIndex + 1)
        
        return viewControllerAtIndex(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if currentIndex == 0 {
            return nil
        }
        
        currentIndex = currentIndex - 1
        return viewControllerAtIndex(index: currentIndex)
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        let dict = listPhotoItem[currentIndex].post
//        lblTitle.text = dict["title"] as! String
    }
}
