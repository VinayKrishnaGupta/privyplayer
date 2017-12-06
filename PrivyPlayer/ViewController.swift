//
//  ViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 06/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionview: UICollectionView!
 
    let Videocontroller = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        self.navigationItem.title = "Privy Player"
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])

      //  let VideoURL = storage.reference(forURL: "gs://mshmshtv-6e148.appspot.com/Feem __ .mp4")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.playvideo()
    }
    
    
    
    func playvideo() {
        
        
         let videoURL:URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/mshmshtv-6e148.appspot.com/o/Haanikaarak%20Bapu%20-%20Dangal%20_%20Aamir%20Khan%20_%20Pritam%20_Amitabh%20B_%20Sarwar%20%26%20Sartaz%20Khan%20_%20New%20Song%202017%20-%20YouTube%20(360p).mp4?alt=media&token=0eacd77d-67e2-4852-b57b-f20a5be6cf13")!
        let player = AVPlayer(url: videoURL)
        player.allowsExternalPlayback = true
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

