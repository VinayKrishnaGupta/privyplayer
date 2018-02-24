//
//  SignInViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 11/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if (UserDefaults.standard.value(forKey: "UserID") != nil) {
            let userID = UserDefaults.standard.value(forKey: "UserID") as? String
            if (userID == "0") {
                return
            }
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "customsideVC")
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 200/256, green: 54/256, blue: 54/256, alpha: 1)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SignInButton(_ sender: Any) {
        
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            SCLAlertView().showError("Error", subTitle: "All Fields are Mandetory")
        }
        else {
             SCLAlertView().showWait("Please Wait", subTitle: "Sigining In")
             self.SigninMethod()
        }
        
       
        
        
        
    }
    
    func SigninMethod() {
       
        let username: String = self.emailTextField.text!
        let password : String = self.passwordTextField.text!
        
        let parameter1 : Parameters  = ["email_id" : username , "password": password] as Parameters
        
      Alamofire.request("http://gig.gs/API_V2/API/login", method: .post, parameters: parameter1, headers: nil)
        .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "status.type") as! String
                    let message: String = dict.value(forKeyPath: "status.message") as! String
                    if type == "Success" {
                        
                        let userID = dict.value(forKeyPath: "response.user_id")
                        UserDefaults.standard.set(userID, forKey: "UserID")
                        UserDefaults.standard.synchronize()
                        
                        SCLAlertView().showSuccess("Success", subTitle: "Successfully Logged In")
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "customsideVC")
                        self.present(vc, animated: true, completion: nil)
                    }
                    else {
                        SCLAlertView().showError("Error", subTitle: message)
                    }
                    
                    
                   
                    
                }
                else {
                SCLAlertView().showError("Error", subTitle: "Login Failed, Please Try Again")
                
                    
                    
                    print("Error")
                }
                
        }
        
        
        
        
    }
    @IBAction func MovetoSignup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignupVC", sender: self)
    }
    
    @IBAction func ContinueAsGuest(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "customsideVC")
        self.present(vc, animated: true, completion: nil)
        let userID = "0"
        UserDefaults.standard.set(userID, forKey: "UserID")
        UserDefaults.standard.synchronize()
        
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
