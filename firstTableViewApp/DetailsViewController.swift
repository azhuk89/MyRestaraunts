//
//  DetailsViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/8/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, QuickReviewViewControllerDelegate {

    @IBOutlet weak var restarauntImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func close (segue: UIStoryboardSegue) {}
    
    var restaraunt: Restaraunt!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.restarauntImageView.image = UIImage(data: self.restaraunt.image)
        
        self.tableView.backgroundColor = UIColor(red: 250 / 255, green: 212 / 255, blue: 255 / 255, alpha: 1.0)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorColor = UIColor.blackColor()
    
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = restaraunt.name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailsCell", forIndexPath: indexPath) as! DetailsTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = restaraunt.name
        case 1:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = restaraunt.type
        case 2:
            cell.keyLabel.text = "Location"
            cell.valueLabel.text = restaraunt.location
        case 3:
            cell.keyLabel.text = "Have been there"
            cell.valueLabel.text = restaraunt.isVisited.boolValue ? "Yes" : "No"
        default:
            cell.keyLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            self.performSegueWithIdentifier("showTheMap", sender: nil)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTheMap" {
            let destinationVC = segue.destinationViewController as! RestarauntLocationViewController
            destinationVC.restaraunt = restaraunt
        } else if segue.identifier == "showRatingView" {
            let destinationVC = segue.destinationViewController as! QuickReviewViewController
            destinationVC.delegate = self
        }
    }
    
    func ratingDidChange(value: Int) {
        print(value)
    }

}
