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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem.init(image: UIImage.init(named: "searchIcon"), style: .done, target: self, action: #selector(SearchButtonMethod))
        self.navigationItem.rightBarButtonItem = searchButton
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func SearchButtonMethod(){
        // self.performSegue(withIdentifier: "searchVC", sender: self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SubmitButtonMethod(){
        
        if (videoTitleTextField.text?.isEmpty)! {
            print("All Fields are Mandetory")
        }
        else {
            let UserID : String = UserDefaults.standard.value(forKey: "UserID") as! String
            let VideoTitle : String = self.videoTitleTextField.text!

            
            let parameter = ["video_title": VideoTitle, "user_id":UserID ]
            Alamofire.request("http://gig.gs/API_V2/API/requestVideo", method: .post, parameters: parameter, headers:nil)
                .responseJSON { response in
                    debugPrint(response)
                    
                    
                    if let json = response.result.value {
                        let dict = json as! NSDictionary
                        print(dict)
                        let type : String = dict.value(forKeyPath: "status.type") as! String
                        if type == "Success" {
                            self.videoTitleTextField.text = nil

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
