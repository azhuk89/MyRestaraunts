//
//  ContentPageViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 3/9/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class ContentPageViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var index = 0
    var header = ""
    var subheader = ""
    var imageFile = ""
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "appAlreadySeen")
    }
    
    @IBAction func nextScreen(sender: AnyObject) {
        let pageVC = self.parentViewController as! PageViewController
        pageVC.next(index)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = header
        subHeaderLabel.text = subheader
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        proceedButton.hidden = (index == 0) ? true : false
        nextButton.hidden = (index == 1) ? true : false
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

}
