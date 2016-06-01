//
//  AboutUsViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 3/15/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit
import MessageUI

class AboutUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBAction func sendMail(sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["azhuk89@gmail.com"])
            mailComposeVC.setSubject("test")
            
            mailComposeVC.navigationBar.tintColor = UIColor.whiteColor()
            presentViewController(mailComposeVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {

        switch result.rawValue {
        case MFMailComposeResultSaved.rawValue:
            print("the message was saved")
        case MFMailComposeResultCancelled.rawValue:
            print("the message was canceled")
        case MFMailComposeResultSent.rawValue:
            print("the message was sent")
        case MFMailComposeResultFailed.rawValue:
            print("the message was failed: \(error?.localizedDescription)")
        default: break
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
