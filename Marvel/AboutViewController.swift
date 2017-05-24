//
//  ViewController.swift
//  Marvel
//
//  Created by Igor on 15.05.17.
//  Copyright © 2017 Igor. All rights reserved.
//

import UIKit


class AboutViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let appBundle = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        
        let str = String(format: "\n%@  %@   \n%@  %@", "version: ", version, "bundle: ", appBundle);
        
        textView.text = textView.text + str;
    }



}

