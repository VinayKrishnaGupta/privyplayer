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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SignInButton(_ sender: Any) {
        
        self.SigninMethod()
        
        
        
    }
    
    func SigninMethod() {
        
        let username: String = self.emailTextField.text!
        let password : String = self.passwordTextField.text!
        
        let parameter1 : Parameters  = ["email_id" : username , "password": password] as Parameters
        
      Alamofire.request("http://mshmsh.tv/login.php", method: .post, parameters: parameter1, headers: nil)
        .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "Response.data.type") as! String
                    let message: String = dict.value(forKeyPath: "Response.data.message") as! String
                    if type == "Success" {
                        SCLAlertView().showSuccess("Sucess", subTitle: "Successfully Logged In")
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
    @IBAction func MovetoSignup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignupVC", sender: self)
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
