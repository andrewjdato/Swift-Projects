//
//  ViewController.swift
//  House Sort
//
//  Created by Andrew Dato on 5/8/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

//Structure for hoem structure will also use
//for cell data in the list
struct Home {
    //Optional Variable used to see the different Homes during sorts
    let name : String
    //Date the house was added
    var dateAdded = Date()
    //Price of the house
    let price : Double
    //Square Feet of the house
    let size : Double
    //Array of images of the house
    let images : [UIImage]
    //Number of bedrooms
    let bed : Int
    //Number of Baths
    let bath : Int
}

class TableViewController: UITableViewController
{

    //Variable used to store the home data
    var homes = [Home]()
    
    //Variable used to Reverse the order
    //0 - None
    //1 - Price
    //2 - Size
    //3 - Date
    var sortType = 0
    
    @IBOutlet var homeTableView: UITableView!
    //
    //Table View Functions
    //Used to organize and display
    //the information
    //    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sortingButton = UIBarButtonItem(title: "Sort", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TableViewController.sortButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = sortingButton
        //Set up the homes variable
        homes = createHomeArray()
        
        //Register to custom cells 
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 500
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Use the custom cell that was made
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        //Set the display details of the homes
        cell.details = "Home Name: \(homes[indexPath.row].name)\nDate Added: \(homes[indexPath.row].dateAdded.description)\nPrice: $\(homes[indexPath.row].price) Size: \(homes[indexPath.row].size) sqft\nBedrooms: \(homes[indexPath.row].bed) Baths: \(homes[indexPath.row].bath)"
        cell.images = homes[indexPath.row].images[0]
        //Set up the subviews
        cell.layoutSubviews()
        return cell
    }
    
    //Used to figure out how many rows are needed to be created
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    //
    //Array Setup Functions
    //Used to create and organize all
    //of the home data used for this test
    //
    //Create an Array of Homes for testing
    func createHomeArray () -> [Home]{
        //Create a temporary List
        var tempList = [Home]()
        
        //Create a loop for getting all the Homes
        for count in 1...30 {
            //Get a random Date and time from the past year
            let day:TimeInterval = 24  * -1 * Double(arc4random_uniform(364) + 1) *
                Double(arc4random_uniform(60) + 1) *
                Double(arc4random_uniform(60) + 1)
            //Create a photo array
            let homeImages = [#imageLiteral(resourceName: "Home1"),#imageLiteral(resourceName: "Home2"),#imageLiteral(resourceName: "Home3"),#imageLiteral(resourceName: "Home4"),#imageLiteral(resourceName: "Home5")]
            //Create a temporary Home Object with random
            //variable used for all the parameters
            let tempHome = Home(name: "House \(count)",
                dateAdded : Date().addingTimeInterval(day),
                price: Double(arc4random_uniform(1000000)),
                size: Double(arc4random_uniform(100000)),
                images: homeImages,
                bed: Int(arc4random_uniform(4)+1),
                bath: Int(arc4random_uniform(4))+1)
            //Add the randomized home to temp list
            tempList.append(tempHome)
        }
        //Return the full temp list
        return tempList
    }
    
    //
    //Sort Array Functions
    //Used to sort the list and
    //refresh the page to display new results
    //
    //Navigation button used to go to the next page
    @objc func sortButtonAction(_ button: UIBarButtonItem) {
        //Set the view controller to go to
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SortViewController") as! SortViewController
        //Set the delegate of the view controller
        selectionVC.selectDelegate = self as SortSelctionDelegate
        //Display the new screen
        present(selectionVC,animated: true, completion: nil)
        
    }
    
    //Randomly Sort the Homes
    /*
     Algorithim:
     At every point in the array
     generate a random number for
     the remaining size of the array
     and swap that point of the array
     with the randomly generated one and
     move to the next iteration of the loop
     */
    func randomSort() {
        //Create a temporary variable
        var sortedHomes = homes
        //Traverse the Array
        for count in 0...29 {
            //Generate a random swap position from the remaining size
            let swapPostion = arc4random_uniform(UInt32(29 - count))
            //Move on to the next loop if it lands on the same position as the number
            if (swapPostion == 0) {
                continue
            }
            //create a temporary variable to hold the home
            let homeHolder = sortedHomes[Int(Int(swapPostion)+count)]
            //Swap the Homes
            sortedHomes[Int(Int(swapPostion)+count)] = sortedHomes[count]
            sortedHomes[count] = homeHolder
        }
        //Set the temporary to the original
        homes = sortedHomes
        //Reload the data on the table to reflect the changes
        self.homeTableView.reloadData()
    }

}

//Extension of the sort delegate from the previous controller
extension TableViewController: SortSelctionDelegate {
    func didChooseChoice(type: String) {
        switch type {
        case "random":
            //Sort randomly using the function above
            sortType = 0
            randomSort()
        case "price":
            //Sort the price of the homes using a built in sort function
            if sortType != 1 {
                sortType = 1
                homes = homes.sorted { $0.price > $1.price}
                self.homeTableView.reloadData()
            } else {
                //Reverse the list if its already sorted by price
                homes = homes.reversed()
                self.homeTableView.reloadData()
            }
            
        case "size":
            //Sort the size of the homes using a built in sort function
            if sortType != 2 {
                sortType = 2
                homes = homes.sorted { $0.size > $1.size}
                self.homeTableView.reloadData()
            } else {
                //Reverse the list if its already sorted by size
                homes = homes.reversed()
                self.homeTableView.reloadData()
            }
        case "date":
            //Sort the date of the homes using a built in sort function
            if sortType != 3 {
                sortType = 3
                homes = homes.sorted { $0.dateAdded > $1.dateAdded}
                self.homeTableView.reloadData()
            } else {
                //Reverse the list if its already sorted by date
                homes = homes.reversed()
                self.homeTableView.reloadData()
            }
        default:
            print("Not a Valid Option")
        }
    }
    
}

