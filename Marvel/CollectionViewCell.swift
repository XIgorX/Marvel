//
//  CollectionViewCell.swift
//  Marvel
//
//  Created by Igor on 18.05.17.
//  Copyright © 2017 Igor. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //@IBOutlet weak var button: UIButton!
    //@IBOutlet weak var label: UILabel!
    
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        
        /*let button:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        button.backgroundColor = UIColor.blue
        //button?.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(button)
        self.button = button*/
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: frame.size.height*2/3, width: frame.size.width, height: frame.size.height/3))
        //textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        label.textAlignment = .center
        contentView.addSubview(label)
        self.label = label;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }*/
    

}


