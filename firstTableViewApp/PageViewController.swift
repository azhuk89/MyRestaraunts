//
//  PageViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 3/9/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var headersArray = ["Create", "Find"]
    var subheadersArray = ["Create a list of restaraunts that you like", "Find and mark your restaraunt on the map"]
    var imagesArray = ["rest", "map"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let firstVC = self.showViewControllerAtIndex(0) {
            setViewControllers([firstVC], direction: .Forward, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showViewControllerAtIndex(index: Int) -> ContentPageViewController? {
        
        if index >= 0 && index < headersArray.count {
            if let contentPageViewController = storyboard?.instantiateViewControllerWithIdentifier("ContentPageViewController") as? ContentPageViewController {
                
                contentPageViewController.index = index
                contentPageViewController.header = headersArray[index]
                contentPageViewController.subheader = subheadersArray[index]
                contentPageViewController.imageFile = imagesArray[index]
                
                return contentPageViewController
            }
        }
        
        return nil
    }
    
    //MARK: - page vc data source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentPageViewController).index
        index -= 1
        return self.showViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentPageViewController).index
        index += 1
        return self.showViewControllerAtIndex(index)
    }
    
    //MARK: - page vc stadart page identifiers
    
    func next(index: Int) {
        if let nextVC = self.showViewControllerAtIndex(index + 1) {
            setViewControllers([nextVC], direction: .Forward, animated: true, completion: nil)
        }
    }
}
