//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

//BusinessViewController is the controller
class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //businesses property
    var businesses: [Business]!
    
    //tableViewOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the delegate and the dataSource to the viewController
        tableView.delegate = self
        tableView.dataSource = self
        
        //
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //Search terms for results
        Business.searchWithTerm(term: "Indian", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            //Sets the businesses with the businesses property
            self.businesses = businesses
            
            //Reloads the tableView with new data
            self.tableView.reloadData()
            
            //Prints the name and address of each business
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        })
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    //numberOfRowsInSections: the number of cells in the table
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    //cellForRowAt: The content of the cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //creating the cell and casting it to BusinessCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        //Retrieving the correct business to display in the cell
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
