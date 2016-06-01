//
//  ShareViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/17/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topLeftView.transform = CGAffineTransformMakeTranslation(-300, -500)
        self.topRightView.transform = CGAffineTransformMakeTranslation(300, -500)
        self.bottomLeftView.transform = CGAffineTransformMakeTranslation(-300, 500)
        self.bottomRightView.transform = CGAffineTransformMakeTranslation(300, 500)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.topLeftView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.topRightView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.bottomLeftView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.bottomRightView.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
