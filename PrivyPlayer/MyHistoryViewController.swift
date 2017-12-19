//
//  MyHistoryViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 15/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit
import SDWebImage
import SCLAlertView

class MyHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "My History"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.GetHistory()
        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "searchIcon"), style: .done, target: self, action: #selector(SearchButtonMethod))
        self.navigationItem.rightBarButtonItem = searchButton
        
    }
    func SearchButtonMethod(){
        // self.performSegue(withIdentifier: "searchVC", sender: self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
        
        if dataArray.count>0 {
            let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
            let title : String = dict.value(forKeyPath: "video title") as! String
            cell.textLabel?.text = title
            let VideoURL: String = dict.value(forKey: "video url") as! String
            cell.imageView?.image = UIImage.init(named: "video-player")
            cell.tag = indexPath.section
            
            DispatchQueue.global(qos: .userInitiated).async {
                let thumbnailImage = self.getThumbnailImage(forUrl: URL(string: VideoURL)!)
                
                DispatchQueue.main.async {
                    if (cell.tag == indexPath.section) {
                        cell.imageView?.image = thumbnailImage
                    }
                    
                    
                    
                }
            }
            
            
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
        let VideoURL: String = dict.value(forKey: "video url") as! String
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
    
    
    
    func GetHistory() {
        
        let userID : String = UserDefaults.standard.value(forKey: "UserID") as! String
        
        Alamofire.request("http://gig.gs/get_history.php", method: .post, parameters: ["user_id":userID], headers:nil)
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "response.type") as! String
                    if type == "success" {
                        
                        self.dataArray = dict.value(forKeyPath: "response.message") as! [Any]
                        
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                    else {
                        print("No Video found")
                        self.tableView.isHidden = true
                        SCLAlertView().showError("No Videos Found", subTitle: "Please watch Videos to see your history")
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

