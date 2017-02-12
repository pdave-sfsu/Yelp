//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

//BusinessViewController is the controller
class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //businesses property
    var businesses: [Business]!
    var filterbusinesses: [Business]!

    
    //tableViewOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the delegate and the dataSource to the viewController
        tableView.delegate = self
        tableView.dataSource = self
        
        //Tells the table to follow the auto-layout constraint rules
        tableView.rowHeight = UITableViewAutomaticDimension
        //Estimated for the scrollHeight Dimension
        tableView.estimatedRowHeight = 120
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        navigationItem.titleView = searchBar
        
        //Search terms for results
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            //Sets the businesses with the businesses property
            self.businesses = businesses
            self.filterbusinesses = self.businesses
            
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
        if filterbusinesses != nil {
            return filterbusinesses.count
        } else {
            return 0
        }
    }
    
    //cellForRowAt: The content of the cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //creating the cell and casting it to BusinessCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        //Retrieving the correct business to display in the cell
        cell.business = filterbusinesses[indexPath.row]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterbusinesses = searchText.isEmpty ? businesses : businesses?.filter({(dataString: Business) -> Bool in
            return dataString.name!.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
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
