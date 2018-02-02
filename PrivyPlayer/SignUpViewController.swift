//
//  SignUpViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 11/12/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SCLAlertView
import Alamofire

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let MySCLView = SCLAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func signUpButton(_ sender: UIButton) {
        if (fullNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            SCLAlertView().showError("Error", subTitle: "All Fields are Mandetory")
        }
        else {
            MySCLView.showWait("Please Wait..", subTitle: "We are Registering your account")
           self.SignupMethod()
        }
        
        
        
    }
    
    
    func SignupMethod(){
        
        let username: String = self.emailTextField.text!
        let password : String = self.passwordTextField.text!
        let Fullname : String = self.fullNameTextField.text!
        
        let parameter1 : Parameters  = ["email_id" : username , "password": password, "username":Fullname] as Parameters
        
      //  Alamofire.request("http://gig.gs/API_V2/API/signUp.php", method: .post, parameters: parameter1, headers: nil)
        Alamofire.request("http://gig.gs/API_V2/API/signUp", method: .post, parameters: parameter1, headers: nil)
            .responseJSON { response in
                debugPrint(response)
               
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "status.type") as! String
                    let message: String = dict.value(forKeyPath: "status.message") as! String
                    if type == "Success" {
                        self.SigninMethod()
                    }
                    else {
                        SCLAlertView().showError("Error", subTitle: message)
                        self.MySCLView.hideView()
                    }
                    
                    
                    
                    
                }
                else {
                    SCLAlertView().showError("Error", subTitle: "Failed")
                    
                    
                    
                    print("Error")
                }
                
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
                        self.MySCLView.hideView()
                        let userID = dict.value(forKeyPath: "response.user_id")
                        UserDefaults.standard.set(userID, forKey: "UserID")
                        UserDefaults.standard.synchronize()
                        
                        SCLAlertView().showSuccess("Success", subTitle: "Successfully Logged In")
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
