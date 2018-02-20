//
//  VideoDetailViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 17/02/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VideoDetailViewController: UIViewController {
    public var VideoURL = String()
    public var SelectedVideoObject = NSDictionary()
    
    @IBOutlet var overLayImage: UIImageView!
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var videoTitleTextView: UITextView!
    @IBOutlet var videoDescriptionTextView: UITextView!
    
    @IBOutlet var descriptionTitle: UILabel!
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        //        //ProductionID
        //       // bannerView.adUnitID = "ca-app-pub-1687791729093117/8134087614"
        //        //TestID
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bannerView)
        
        //  self.view.layer.addSublayer(bannerView.layer)
        
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal,
                                              toItem: bottomLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal,
                                              toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        videoDescriptionTextView.isHidden = true
        descriptionTitle.isHidden = true
        print(SelectedVideoObject)
        let VideoTitle : String = self.SelectedVideoObject.value(forKeyPath: "title") as! String
        videoTitleTextView.text = VideoTitle
        let VideoDescription : String = self.SelectedVideoObject.value(forKeyPath: "description") as! String
        videoDescriptionTextView.text = VideoDescription
        
        print("Video Description Count is \(VideoDescription.count)")
        if VideoDescription.count > 1 {
            videoDescriptionTextView.isHidden = false
            descriptionTitle.isHidden = false
        }
        
       
        
        let VideoImageURl : String = self.SelectedVideoObject.value(forKeyPath: "previewImage") as! String
        videoImageView.sd_setImage(with: URL(string:VideoImageURl), completed: nil)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(MoveToPlayVideoVC))
        overLayImage.addGestureRecognizer(tap)
        overLayImage.isUserInteractionEnabled = true
      
        
   
        
//        let overlayImageView = UIImageView.init(image: UIImage.init(named: "filmreels"))
//        overlayImageView.frame = videoImageView.frame
//        overlayImageView.clipsToBounds = true
//        overlayImageView.alpha = 0.5
//
//        videoImageView.addSubview(overlayImageView)
    }
    func MoveToPlayVideoVC () {
        print("Play Video Pressed")
        self.performSegue(withIdentifier: "myAVplayer", sender: VideoURL)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myAVplayer" {
            let vc = segue.destination as! MyAVPlayerViewController
            vc.videoURLfromHome = sender as! String
        }
    }
    
    @IBAction func shareButton(_ sender: UIButton)
    {
        let VideoTitle : String = self.SelectedVideoObject.value(forKeyPath: "title") as! String
        let text = "Download gig.gs iPhone App from https://goo.gl/UvhWoz or Watch Video : " + VideoTitle + " from " + VideoURL
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToTwitter ]
        
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
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



extension UIImage {
    func overlayed(with overlay: UIImage) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        overlay.draw(in: CGRect(origin: CGPoint.zero, size: size))
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        }
        return nil
    }
}

