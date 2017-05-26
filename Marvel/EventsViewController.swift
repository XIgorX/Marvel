//
//  EventsViewController.swift
//  Marvel
//
//  Created by Igor on 23.05.17.
//  Copyright © 2017 Igor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//import "MD5.swift"

private let reuseIdentifier = "Cell"

class EventsViewController: UICollectionViewController {
    
    var idsList = [Int]();
    var eventsList = [String]();
    var imagesList = [String]();
    
    var loadMoreStatus = false
    var countRow = 20
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: "refresh:", for: UIControlEvents.valueChanged)
        
        collectionView?.addSubview(refreshControl)

        let defaults = UserDefaults.standard
        let id: Int = defaults.integer(forKey: "currentID")
        
        Alamofire.request(String(format: "https://gateway.marvel.com/v1/public/characters/%i/events?ts=%i&apikey=%@&hash=%@&limit=%i", id, timestamp, public_key, md5_hash, request_limit), method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                for i in 0..<json["data"]["results"].count
                {
                    self.idsList.append(json["data"]["results"][i]["id"].int!);
                    self.eventsList.append(json["data"]["results"][i]["title"].string!);
                    self.imagesList.append(String(format: "%@.%@", json["data"]["results"][i]["thumbnail"]["path"].string!,json["data"]["results"][i]["thumbnail"]["extension"].string!))
                    
                }
                
                for (index, value) in self.idsList.enumerated() {
                    print("Item \(index + 1): \(value)")
                }
                for (index, value) in self.eventsList.enumerated() {
                    print("Item \(index + 1): \(value)")
                }
                for (index, value) in self.imagesList.enumerated() {
                    print("Item \(index + 1): \(value)")
                }
                
                self.collectionView?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    /*
     // #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // #pragma mark UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        let min = self.imagesList.count < countRow  ? self.imagesList.count : countRow
        //return self.imagesList.count
        return min
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        var path = self.imagesList[indexPath.row]
        path.insert("s", at: path.index(path.startIndex,offsetBy: 4))
        let url = URL(string: path)
        
        cell.label?.text = self.eventsList[indexPath.row];
        cell.image.image = nil
        
        
        // Move to a background thread to do some long running work
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            if let data = try? Data(contentsOf: url!){ //make sure your image in this url does exist, otherwise unwrap in a if let check / try catch
                DispatchQueue.main.async {
                    cell.image.image = UIImage(data: data)
                }
            }
        }
        
        
        return cell
    }
    
    // #pragma mark UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath)
    {
        let defaults = UserDefaults.standard
        defaults.set(idsList[indexPath.row], forKey: "currentID")
    }
    
    // refresh control methods
    
    func refresh(sender:AnyObject) {
        refreshBegin(newtext: "Refresh",
                     refreshEnd: {(x:Int) -> () in
                        self.collectionView?.reloadData()
                        self.refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            
            print("refreshing")
            //self.text = newtext
            sleep(2)
            
            DispatchQueue.main.async {
                refreshEnd(0)
            }
        }
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func loadMore() {
        if ( !loadMoreStatus ) {
            self.loadMoreStatus = true
            //self.activityIndicator.startAnimating()
            //self.tableView.tableFooterView.hidden = false
            loadMoreBegin(newtext: "Load more",
                          loadMoreEnd: {(x:Int) -> () in
                            self.collectionView?.reloadData()
                            self.loadMoreStatus = false
                            //self.activityIndicator.stopAnimating()
                            //self.tableView.tableFooterView.hidden = true
            })
        }
    }
    
    func loadMoreBegin(newtext:String, loadMoreEnd:@escaping (Int) -> ()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            print("loadmore")
            //self.text = newtext
            self.countRow += 20
            sleep(2)
            
            DispatchQueue.main.async {
                loadMoreEnd(0)
            }
        }
    }
    
    
}
