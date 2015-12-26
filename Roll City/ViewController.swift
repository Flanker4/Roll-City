//
//  ViewController.swift
//  Roll City
//
//  Created by Ivan Melnikov on 15.11.15.
//  Copyright © 2015 Ivan Melnikov. All rights reserved.
//



import UIKit
import Parse



class ViewController: DLHamburguerViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        self.contentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NavigationViewController") 
        self.menuViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
    }
}


class ViewController2: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var testarray = [String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let query = PFQuery(className: "Hot_b")
        let runkey = query.orderByAscending("name")
        runkey.findObjectsInBackgroundWithBlock{
            (object: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let object = object as [PFObject]! {
                    for object in object {
                        let load = object.objectForKey("name") as! String
                        self.testarray.append(load)
                    }
                }
                
            }else{
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
       sleep(1)
        do_table_refresh ()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func do_table_refresh ()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testarray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        cell.lbTitle.text = testarray [indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailSegue"){
            // check for / catch all visible cell(s)
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object: String = testarray[indexPath.row]
                (segue.destinationViewController as! DetailView).currentObject = object as? PFObject
                
            }        }
    }
}
