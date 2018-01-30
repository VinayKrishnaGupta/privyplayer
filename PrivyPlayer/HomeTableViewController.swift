//
//  HomeTableViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 11/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire
import SCLAlertView
import GoogleMobileAds





class HomeTableViewController: UITableViewController, GADInterstitialDelegate{
    var ResponseArray = Array<Any>()
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    var interstitial: GADInterstitial!
    var SelectedVideoDict = NSDictionary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544")
        let request = GADRequest()
        interstitial.load(request)
        interstitial = createAndLoadInterstitial()
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])

        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "searchIcon"), style: .done, target: self, action: #selector(SearchButtonMethod))
        let uploadButton = UIBarButtonItem.init(image: UIImage.init(named: "videoUpload"), style: .done, target: self, action: #selector(upLoadButtonMethod))
       self.navigationItem.rightBarButtonItem = searchButton
      //  self.navigationItem.rightBarButtonItems = [uploadButton, searchButton]
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let UserID : String = UserDefaults.standard.value(forKey: "UserID") as! String
        Alamofire.request("http://gig.gs/API_V2/API/fetchVideos", method: .post, parameters:["user_id":UserID] , headers: ["Token":"d75542712c868c1690110db641ba01a"])
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    AppDataManager.sharedInstance.VideoResponsefromHomeAPI = dict.value(forKey: "response") as! [Any]
                    AppDataManager.sharedInstance.CategoryNameList = dict.value(forKeyPath: "response.CategoryName") as! [String]
                  
                   
                    self.tableView.reloadData()
                }
                else {
                    
                    print("Error")
                }
                
        }
        
        
        
    }
    
    
    func SearchButtonMethod(){
      // self.performSegue(withIdentifier: "searchVC", sender: self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func upLoadButtonMethod(){
        print("uploadButton")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("Model . count is \(model.count)")
        if (AppDataManager.sharedInstance.VideoResponsefromHomeAPI.count != 0) {
            return AppDataManager.sharedInstance.VideoResponsefromHomeAPI.count
        }
        else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        if AppDataManager.sharedInstance.CategoryNameList.isEmpty {
            return ""
        }
        else {
            return AppDataManager.sharedInstance.CategoryNameList[section]
        }
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.section] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.groupTableViewBackground
        header.textLabel?.text = self.tableView(tableView, titleForHeaderInSection: section)
        header.textLabel?.font = UIFont(name: "Rubik", size: 16)
        header.textLabel?.textAlignment = NSTextAlignment.left
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        storedOffsets[indexPath.section] = tableViewCell.collectionViewOffset
    }
}

extension HomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return model[collectionView.tag].count
        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
        
        return VideoList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCollectionViewCell
        cell.tag = (indexPath.row)*101
        //  cell.backgroundColor = model[collectionView.tag][indexPath.item]
        cell.backgroundColor = UIColor.groupTableViewBackground
        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
        let dict : NSDictionary = VideoList[indexPath.row] as! NSDictionary
        let CellTitle : String = dict.value(forKey: "title") as! String
        cell.videotitleLabel.text = CellTitle
        let previewImageURL : String = dict.value(forKey: "previewImage") as! String
        cell.playbuttonImageView.sd_setImage(with: URL(string:previewImageURL), completed: nil)
     //   let VideoURLfromAPI : String = dict.value(forKey: "url") as! String
        
      //  let VideoURLfromAPI : String = "https://gig.gs/videos/360p/9514810031.mp4"
        
//         let videoURL:URL = URL(string: VideoURLfromAPI)!
//        cell.playbuttonImageView.jp_playVideo(with: videoURL)
//
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            let thumbnailImage = self.getThumbnailImage(forUrl: URL(string: VideoURLfromAPI)!)
//           
//            DispatchQueue.main.async() {
//                if cell.tag == (indexPath.row)*101 {
//                     cell.playbuttonImageView.image = thumbnailImage
//                    
//                    
//                }
//               
//                
//            }
//        }

        
       
        
        
        return cell
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        var interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544")
        //ca-app-pub-3940256099942544 : test
        //ca-app-pub-1388255702174478/2655077021 : prod
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
        SelectedVideoDict = VideoList[indexPath.row] as! NSDictionary
        
        let VideoURLList : Array<String> = SelectedVideoDict.value(forKey: "url") as! Array<String>
        let VideoURLfromAPI : String =  VideoURLList.last!
        print("Selected Video URL is \(VideoURLfromAPI)")
        
        self.performSegue(withIdentifier: "playerView", sender: VideoURLfromAPI)
        
        DispatchQueue.global(qos: .userInitiated).async {
                let userID : String = UserDefaults.standard.value(forKey: "UserID") as! String
            let VideoID : String = self.SelectedVideoDict.value(forKeyPath: "reference_id") as! String
                let parameter  = ["userId": userID , "videoId": VideoID]
                Alamofire.request("http://gig.gs/API_V2/API/createHistory", method: .post, parameters: parameter, headers:nil)
                    .responseJSON { response in
                        debugPrint(response)
                        if let json = response.result.value
                        {
                            let dict = json as! NSDictionary
                            print(dict)
                        }
                        else
                        {
                            print("Error")
                        }
                }
            
    }
        
     // self.playvideo(VideoURL: VideoURLfromAPI)
        
        
//
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
//        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
//        let dict : NSDictionary = VideoList[indexPath.row] as! NSDictionary
//      //  let VideoURLfromAPI : String = dict.value(forKey: "url") as! String
//        let VideoURLfromAPI : String = "http://gig.gs/videos/360p/9514810031.mp4"
//      // self.playvideo(VideoURL: VideoURLfromAPI)
//        self.playvideo1(VideoURL: VideoURLfromAPI)
//
//         DispatchQueue.global(qos: .userInitiated).async {
//
//

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerView" {
            let vc = segue.destination as! PlayerVideoViewController
            vc.VideoURL = sender as! String
            vc.SelectedVideoObject = self.SelectedVideoDict
        }
        if segue.identifier == "playerView2" {
            let vc = segue.destination as! AVplayerViewController
            vc.VideoURL = sender as! String
        }
    }
    
    
    func playvideo(VideoURL:String) {
        
        
        let videoURL:URL = URL(string: VideoURL)!
        //let playerItem = CachingPlayerItem(url: videoURL)
        let avAsset = AVURLAsset(url: videoURL as URL, options: nil)
        
        let playerItem : AVPlayerItem = AVPlayerItem(asset: avAsset)
        
        let player = AVPlayer(playerItem: playerItem)
        if #available(iOS 10.0, *) {
            player.automaticallyWaitsToMinimizeStalling = false
        } else {
            // Fallback on earlier versions
        }
      
        player.allowsExternalPlayback = true
    //    player.appliesMediaSelectionCriteriaAutomatically = true
         NotificationCenter.default.addObserver(self,selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        NotificationCenter.default.addObserver(self,selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController)
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
           

//            if self.interstitial.isReady {
//               playerViewController.player!.pause()
//                self.interstitial.present(fromRootViewController: playerViewController)
//
//            } else {
//                print("Ad wasn't ready")
//
//            }
            
          
        }
        
    }
    
    
     func playvideo1(VideoURL:String) {
       
        
        let videoURL = NSURL(string: VideoURL)
        let playerAV = AVPlayer(url: videoURL! as URL)
        let playerLayerAV = AVPlayerLayer(player: playerAV)
        playerLayerAV.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayerAV)
        playerAV.play()
        
        
    }
    
   func playerDidFinishPlaying() {
        print("Video End")
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            
            
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
    
}

