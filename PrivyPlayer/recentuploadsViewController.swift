//
//  recentuploadsViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 15/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire

class recentuploadsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "Recent Uploads"
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 200/256, green: 54/256, blue: 54/256, alpha: 1)
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func BackButtonmethod() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyHistoryTableViewCell
        
        if dataArray.count>0 {
            let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
            let title : String = dict.value(forKeyPath: "title") as! String
            cell.HistoryTitle.text = title
            // let VideoURL: String = dict.value(forKey: "video url") as! String
            
            let previewImageURL : String = dict.value(forKey: "previewImage") as! String
            cell.HistoryImageView.sd_setImage(with: URL(string:previewImageURL), completed: nil)
            cell.layer.cornerRadius = 5
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : NSDictionary = dataArray[indexPath.section] as! NSDictionary
        let VideoURLArray : Array<String> = dict.value(forKey: "url") as! Array<String>
        let VideoURL: String = VideoURLArray.last!
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
        
      
        let UserID : String = UserDefaults.standard.value(forKey: "UserID") as! String
        Alamofire.request("http://gig.gs/API_V2/API/recentVideo", method: .post, parameters: ["user_id":UserID], headers:nil)
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "status.type") as! String
                    if type == "Success" {
                        
                        let responseArray : Array<Any> = dict.value(forKey: "response") as! Array<Any>
                        let responseDict : NSDictionary = responseArray.first as! NSDictionary
                        self.dataArray = responseDict.value(forKey: "videos") as! [Any]
                        
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                    else {
                        print("No Video found")
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


