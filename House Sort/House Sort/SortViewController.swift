//
//  SortViewController.swift
//  House Sort
//
//  Created by Andrew Dato on 5/10/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit

//Protocol for the delegate controller for the sorts
protocol SortSelctionDelegate {
    func didChooseChoice(type: String)
}

class SortViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Initialize the Delegate
    var selectDelegate: SortSelctionDelegate!
    
    //Add in the command for the different sorts
    @IBAction func randomSort(_ sender: Any) {
        selectDelegate.didChooseChoice(type: "random")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func priceSort(_ sender: Any) {
        selectDelegate.didChooseChoice(type: "price")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sizeSort(_ sender: Any) {
        selectDelegate.didChooseChoice(type: "size")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateAddedSort(_ sender: Any) {
        selectDelegate.didChooseChoice(type: "date")
        dismiss(animated: true, completion: nil)
        
    }
    
}
