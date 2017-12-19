//
//  RequestVideoViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 17/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class RequestVideoViewController: UIViewController {
    @IBOutlet weak var videoTitleTextField: UITextField!
    @IBOutlet weak var VideoCategoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "searchIcon"), style: .done, target: self, action: #selector(SearchButtonMethod))
        self.navigationItem.rightBarButtonItem = searchButton
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func SearchButtonMethod(){
        // self.performSegue(withIdentifier: "searchVC", sender: self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SubmitButtonMethod(){
        
        if (videoTitleTextField.text?.isEmpty)! || (VideoCategoryTextField.text?.isEmpty)! {
            print("All Fields are Mandetory")
        }
        else {
            let UserID : String = "1"
            let VideoTitle : String = self.videoTitleTextField.text!
            let VideoCategory : String = self.VideoCategoryTextField.text!
            
            let parameter = ["video_title": VideoTitle, "user_id":UserID, "video_category": VideoCategory ]
            Alamofire.request("http://gig.gs/request_video.php", method: .post, parameters: parameter, headers:nil)
                .responseJSON { response in
                    debugPrint(response)
                    
                    
                    if let json = response.result.value {
                        let dict = json as! NSDictionary
                        print(dict)
                        let type : String = dict.value(forKeyPath: "response.type") as! String
                        if type == "success" {
                            self.videoTitleTextField.text = nil
                            self.VideoCategoryTextField.text = nil
                             SCLAlertView().showSuccess("Success", subTitle: "We have received your request and Notify You on video Upload")
                            
                            
                        }
                        else {
                            print("No Video found")
                            
                            
                        }
                        
                        
                        
                        
                    }
                    else {
                        
                        print("Error")
                    }
                    
            }
        }
        
        
        
    }
    
    @IBAction func SubmitButton(_ sender: UIButton) {
        
        self.SubmitButtonMethod()
        
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
