//
//  CustomCell.swift
//  House Sort
//
//  Created by Andrew Dato on 5/9/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import UIKit


//Custom Cell To list off the data used for the
//Cell Description
class CustomCell: UITableViewCell {
    
    //Custom Cell Data From Struct
    var details : String?
    var images : UIImage?
    
    //View Initialization
    var detailsView : UITextView = {
        var detailsView = UITextView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.isScrollEnabled = false
        return detailsView
    } ()
    
    var imagesView : UIImageView = {
        var imagesView = UIImageView()
        imagesView.translatesAutoresizingMaskIntoConstraints = false
        imagesView.contentMode = .scaleAspectFit
        return imagesView
    } ()

    
    
    //Set the Cells in the view
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Initialize the Subviews
        self.addSubview(detailsView)
        self.addSubview(imagesView)
        
        //Place the SubViews
        imagesView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imagesView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imagesView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imagesView.bottomAnchor.constraint(equalTo: self.detailsView.topAnchor).isActive = true
        
        detailsView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        detailsView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //detailsView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        
    }
    
    //Add the subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        if let details = details {
            detailsView.text = details
        }
        if let image = images {
            imagesView.image = image
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
