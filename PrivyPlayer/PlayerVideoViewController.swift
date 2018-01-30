//
//  PlayerVideoViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 23/01/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import WebKit
import SDWebImage

class PlayerVideoViewController: UIViewController, WKNavigationDelegate {
public var VideoURL = String()
public var SelectedVideoObject = NSDictionary()
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var videoTitleTextView: UITextView!
    @IBOutlet var videoDescriptionTextView: UITextView!
    
    @IBOutlet var descriptionTitle: UILabel!
    
    
var webView : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        // init and load request in webview.
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2))
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.allowsAirPlayForMediaPlayback = true
        webView.configuration.requiresUserActionForMediaPlayback = false
        webView.clipsToBounds = true
        webView.backgroundColor = UIColor.darkGray
        webView.navigationDelegate = self
        webView.autoresizesSubviews = true
        webView.autoresizingMask = (UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue))))
        
        let url = URL(string: VideoURL)
        let request = URLRequest.init(url: url!)
        webView.load(request)
        webView.allowsLinkPreview = true
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
       
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
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
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
