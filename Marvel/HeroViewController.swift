//
//  HeroViewController.swift
//  Marvel
//
//  Created by Igor on 15.05.17.
//  Copyright © 2017 Igor. All rights reserved.
//

import UIKit
//import Alamofire
import SwiftyJSON

class HeroViewController: UIViewController, UITabBarDelegate{

    
    @IBOutlet var picture: UIImageView!
    @IBOutlet weak var info: UITextView!
    
    var heroName : String = ""
    var heroPicture : String = ""
    var heroInfo : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make picture round
        self.picture.layer.cornerRadius = self.picture.frame.size.width / 2;
        self.picture.clipsToBounds = true;
        
        let defaults = UserDefaults.standard
        let id: Int = defaults.integer(forKey: "currentID")
        
        /*Alamofire.request(String(format: "https://gateway.marvel.com/v1/public/characters/%i?ts=%i&apikey=%@&hash=%@&limit=%i", id, timestamp, public_key, md5_hash, request_limit), method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                

                self.heroName = json["data"]["results"][0]["name"].string!;
                self.heroPicture = String(format: "%@.%@", json["data"]["results"][0]["thumbnail"]["path"].string!,json["data"]["results"][0]["thumbnail"]["extension"].string!)
                self.heroInfo = json["data"]["results"][0]["description"].string!;
                
                print("Name \(self.heroName)")
                print("Path to picture: \(self.heroPicture)")
            
                self.navigationItem.title = self.heroName;
            
                var path : String = self.heroPicture
                path.insert("s", at: path.index(path.startIndex,offsetBy: 4))
                let url = URL(string: path)
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try catch
            
                self.picture.image = UIImage(data: data!)
                self.info.text = self.heroInfo
            
            case .failure(let error):
                print(error)
            }
        }*/
        
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITabBarDelegate
     func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item ", item.tag)
    }    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
