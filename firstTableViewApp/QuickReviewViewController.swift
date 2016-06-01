//
//  QuickReviewViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/16/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

protocol QuickReviewViewControllerDelegate {
    func ratingDidChange(value: Int)
}

class QuickReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var windowView: UIView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var moreOrLessButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    
    var rating = 0
    var delegate: QuickReviewViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let scaleAnimation = CGAffineTransformMakeScale(0.0, 0.0)
        let moveAnimation = CGAffineTransformMakeTranslation(0, 600)
        self.windowView.transform = CGAffineTransformConcat(scaleAnimation, moveAnimation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            let scaleAnimation = CGAffineTransformMakeScale(1.0, 1.0)
            let moveAnimation = CGAffineTransformMakeTranslation(0, 0)
            self.windowView.transform = CGAffineTransformConcat(scaleAnimation, moveAnimation)
            
            }, completion: nil)
    }
    
    @IBAction func changeRatingButtonHandler(sender: AnyObject) {
        
        if sender as! UIButton == goodButton {
            self.delegate.ratingDidChange(3)
        } else if sender as! UIButton == moreOrLessButton {
            self.delegate.ratingDidChange(2)
        } else if sender as! UIButton == badButton {
            self.delegate.ratingDidChange(1)
        }
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
