//
//  SearchViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 13/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit
import GoogleMobileAds
import SCLAlertView

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, GADInterstitialDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
     var interstitial: GADInterstitial!
    
    var is_searching = Bool()
    var dataArray = Array<Any>()
    var searchingDataArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
       self.navigationItem.title = "Search"
        tableView.isHidden = true
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1388255702174478/2655077021")
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
        // Do any additional setup after loading the view.
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-1388255702174478/2655077021")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataArray.count>0 {
            return dataArray.count
        }
        else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Hello Vinay"
        if dataArray.count>0 {
            let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
            let title : String = dict.value(forKeyPath: "title") as! String
            cell.textLabel?.text = title
            let VideoURL: String = dict.value(forKey: "url") as! String
            cell.imageView?.image = UIImage.init(named: "video-player")
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                let thumbnailImage = self.getThumbnailImage(forUrl: URL(string: VideoURL)!)
                
                DispatchQueue.main.sync {
                    cell.imageView?.image = thumbnailImage
                    cell.reloadInputViews()
                }
            }

            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
        let VideoURL: String = dict.value(forKey: "url") as! String
        self.playvideo(VideoURL: VideoURL)
        
        
    }
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//        if (searchBar.text?.isEmpty)!{
//            is_searching = false
//            tableView.reloadData()
//        } else {
//
//            print(searchBar.text)
//
//            is_searching = true
//            searchingDataArray.removeAllObjects()
//
//            tableView.reloadData()
//        }
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("Search Button Clicked")
        self.searchButtonMethod()
    }
    
    func searchButtonMethod() {
        
        let searchquery : String = self.searchBar.text!
        
        Alamofire.request("http://gig.gs/search.php", method: .post, parameters: ["name":searchquery], headers:nil)
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "response.type") as! String
                    if type == "success" {
                        
                        self.dataArray = dict.value(forKeyPath: "values") as! [Any]
                        
                          self.tableView.isHidden = false
                          self.tableView.reloadData()
                    }
                    else {
                        print("No Video found")
                        SCLAlertView().showError("No Video Found", subTitle: "Please Try Something Else or Let Us Know in Request Section")
                        self.tableView.isHidden = true
                        
                    }
                    
                    
                    
                  
                }
                else {
                    
                    print("Error")
                }
                
        }
        
        
        
        
    }
    
    func playvideo(VideoURL:String) {
        
        
        let videoURL:URL = URL(string: VideoURL)!
        let player = AVPlayer(url: videoURL)
        player.allowsExternalPlayback = true
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            
            if self.interstitial.isReady {
                playerViewController.player!.pause()
                self.interstitial.present(fromRootViewController: playerViewController)
                //self.interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
                
                
            }
        }
        
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
