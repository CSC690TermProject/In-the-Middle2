//
//  TableViewController.swift
//  InTheMiddle2
//
//  Created by Justin Abarquez on 5/3/18.
//  Copyright © 2018 Justin Abarquez. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var restaurants: [String] = ["In-N-Out", "Seniore's Pizza", "Cafe Rosso"]
    var addresses: [String] = ["123 Burgertown", "33 Pizza Lane", "San Francisco State University, 1600 Holloway Ave, San Francisco, CA 94132"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let restaurant = restaurants[indexPath.row]
        let address = addresses[indexPath.row]
    
        let cell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "restaurantCell")
        
        cell.labRestaurant.text = restaurant
        cell.labRestaurant.font = UIFont(name: "Avenir", size: 22)
        cell.labAddress.numberOfLines = 0
        cell.labRestaurant.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.labAddress.text = address
        cell.labAddress.font = UIFont(name: "Avenir", size: 17)
        cell.labAddress.contentMode = .scaleToFill
        cell.labAddress.numberOfLines = 0
        cell.labAddress.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.labAddress.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

