//
//  WebSiteViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 3/15/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class WebSiteViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let webSiteURL = NSURL(string: "http://google.com") {
            let request = NSURLRequest(URL: webSiteURL)
            self.webView.loadRequest(request)
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

}
