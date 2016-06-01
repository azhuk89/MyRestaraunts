//
//  AddRestarauntTableViewController.swift
//  MyRestarauntsApp
//
//  Created by Alexandr Zhuk on 2/23/16.
//  Copyright © 2016 Alexandr Zhuk. All rights reserved.
//

import UIKit
import CoreData

class AddRestarauntTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var restaraunt: Restaraunt!
    var isVisited = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func isRestarauntVisited(sender: AnyObject) {
        
        if sender as! UIButton == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 42 / 255, green: 128 / 255, blue: 53 / 255, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
        } else if sender as! UIButton == noButton {
            isVisited = false
            noButton.backgroundColor = UIColor(red: 42 / 255, green: 128 / 255, blue: 53 / 255, alpha: 1.0)
            yesButton.backgroundColor = UIColor.grayColor()
        }
    }
    
    @IBAction func saveRestaraunt() {
        var error = ""
    
        if nameTextField.text!.isEmpty {
            error += "Name "
        }
        if typeTextField.text!.isEmpty {
            error += "Type "
        }
        if locationTextField.text!.isEmpty {
            error += "Location "
        }
        
        if !error.isEmpty {
            let alert = UIAlertController(title: "Error!", message: "Some fields are empty: \(error)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OMG!!! Why???", style: .Default, handler: nil)
            
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        restaraunt = NSEntityDescription.insertNewObjectForEntityForName("Restaraunt", inManagedObjectContext: managedObjectContext) as! Restaraunt
        restaraunt.image = UIImagePNGRepresentation(self.imageView.image!)
        restaraunt.name = nameTextField.text
        restaraunt.type = typeTextField.text
        restaraunt.location = locationTextField.text
        restaraunt.isVisited = self.isVisited
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                print("unable to insert object to coredata: \(nserror.localizedDescription)");
                return
            }
        }
        
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
