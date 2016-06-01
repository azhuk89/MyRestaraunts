//
//  MyRestarauntsTableViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/2/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit
import CoreData

class MyRestarauntsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var fetchedResultController: NSFetchedResultsController!
    var searchController: UISearchController!
    
    var restaraunts: [Restaraunt] = []
    var searchResultsArray: [Restaraunt] = []
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {}
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResultsArray.count
        } else {
            return self.restaraunts.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyRestarauntsTableViewCell
        let restaraunt = searchController.active ? searchResultsArray[indexPath.row] : restaraunts[indexPath.row]
        
        cell.thumbnailImageView.image = UIImage(data: restaraunt.image)
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.height / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        cell.nameLabel.text = restaraunt.name
        cell.locationLabel.text = restaraunt.location
        cell.typeLabel.text = restaraunt.type
        
        cell.isVisitedImageView.hidden = !restaraunt.isVisited.boolValue
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        /*let actionMenu = UIAlertController(title: "", message: "what to do?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionMenu.addAction(cancelAction)
        
        
        let callActionHandler = {(action: UIAlertAction!) -> Void in
            let warning = UIAlertController(title: "Service error", message: "Call service is not available at the moment", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            warning.addAction(okAction)
            self.presentViewController(warning, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Call 12345", style: .Default, handler: callActionHandler)
        actionMenu.addAction(callAction)
        
        let haveBeenThereAction = UIAlertAction(title: "I have been there", style: .Default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            //cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell?.accessoryView = UIImageView(image: UIImage(named: "check-icon-green"))
            self.restarauntsAlreadyVisited[indexPath.row] = true
        })
        
        let haveNeverBeenThereAction = UIAlertAction(title: "I have never been there", style: .Default, handler: {(action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            //cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell?.accessoryView = nil
            self.restarauntsAlreadyVisited[indexPath.row] = false
        })
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryView == nil {
            actionMenu.addAction(haveBeenThereAction)
        } else {
            actionMenu.addAction(haveNeverBeenThereAction)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.presentViewController(actionMenu, animated: true, completion: nil)*/
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /*self.restaurantNames.removeAtIndex(indexPath.row)
        self.restaurantImages.removeAtIndex(indexPath.row)
        self.restarauntLocation.removeAtIndex(indexPath.row)
        self.restarauntTypes.removeAtIndex(indexPath.row)
        self.restarauntsAlreadyVisited.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)*/
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .Default, title: "Share", handler: {
            (UITableViewRowAction, NSIndexPath) -> Void in
           
            let shareActionsMenu = UIAlertController(title: nil, message: "Share on", preferredStyle: .ActionSheet)
            
            let emailShareAction = UIAlertAction(title: "Email", style: .Default, handler: nil)
            let facebookShareAction = UIAlertAction(title: "Facebook", style: .Default, handler: nil)
            let vkShareAction = UIAlertAction(title: "VK", style: .Default, handler: nil)
            let cancelShareAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            
            shareActionsMenu.addAction(emailShareAction)
            shareActionsMenu.addAction(facebookShareAction)
            shareActionsMenu.addAction(vkShareAction)
            shareActionsMenu.addAction(cancelShareAction)
            
            self.presentViewController(shareActionsMenu, animated: true, completion: nil)
        })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {
            (UITableViewRowAction, NSIndexPath) -> Void in
            
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let restarauntToRemove = self.fetchedResultController.objectAtIndexPath(indexPath) as! Restaraunt
            managedObjectContext.deleteObject(restarauntToRemove)
            
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch let error as NSError {
                    print("unable to delete object from coredata: \(error.localizedDescription)");
                    return
                }
            }
        })
        
        shareAction.backgroundColor = UIColor(red: 184 / 255, green: 226 / 255, blue: 181 / 255, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationVC = segue.destinationViewController as! DetailsViewController
                destinationVC.restaraunt = searchController.active ? searchResultsArray[indexPath.row] : restaraunts[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.tableView.estimatedRowHeight = 86
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Restaraunt")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
            self.restaraunts = fetchedResultController.fetchedObjects as! [Restaraunt]
        } catch let ferr as NSError {
            print("unable to perform fetch request: \(ferr.localizedDescription)");
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.whiteColor()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let appAlreadySeen = userDefaults.boolForKey("appAlreadySeen")
        
        if !appAlreadySeen {
            if let pageVC = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                self.presentViewController(pageVC, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    func filterContentFor(searchText: String) {
        searchResultsArray = restaraunts.filter({ (restaraunt: Restaraunt) -> Bool in
            let matchedString = restaraunt.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
            return matchedString != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentFor(searchText!)
        tableView.reloadData()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        
        self.restaraunts = fetchedResultController.fetchedObjects as! [Restaraunt]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
