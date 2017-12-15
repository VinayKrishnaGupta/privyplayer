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


class HomeTableViewController: UITableViewController {
    var ResponseArray = Array<Any>()
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "searchIcon"), style: .done, target: self, action: #selector(SearchButtonMethod))
        self.navigationItem.rightBarButtonItem = searchButton
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        Alamofire.request("http://mshmsh.tv/fetch_videos/fetch_videos.php", method: .get, parameters: nil, headers: ["Token":"d75542712c868c1690110db641ba01a"])
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
        self.performSegue(withIdentifier: "searchVC", sender: self)
        
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
        cell.videotitleLabel.text = "Test Video"
        //  cell.backgroundColor = model[collectionView.tag][indexPath.item]
        cell.backgroundColor = UIColor.groupTableViewBackground
        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
        let dict : NSDictionary = VideoList[indexPath.row] as! NSDictionary
        cell.videotitleLabel.text = dict.value(forKey: "title") as! String
        let VideoURLfromAPI : String = dict.value(forKey: "url") as! String
       
        DispatchQueue.global(qos: .userInitiated).async {
            let thumbnailImage = self.getThumbnailImage(forUrl: URL(string: VideoURLfromAPI)!)
           
            DispatchQueue.main.async {
                cell.playbuttonImageView.image = thumbnailImage
            }
        }

        
       
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        let Category : NSDictionary = AppDataManager.sharedInstance.VideoResponsefromHomeAPI[collectionView.tag] as! NSDictionary
        let VideoList : Array<Any> = Category.value(forKey: "videos") as! Array<Any>
        let dict : NSDictionary = VideoList[indexPath.row] as! NSDictionary
        let VideoURLfromAPI : String = dict.value(forKey: "url") as! String
        self.playvideo(VideoURL: VideoURLfromAPI)
    
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
    
}

