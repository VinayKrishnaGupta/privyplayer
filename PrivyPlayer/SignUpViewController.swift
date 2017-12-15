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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        
        
    }
    
    
    func SignupMethod(){
        
        let username: String = self.emailTextField.text!
        let password : String = self.passwordTextField.text!
        let Fullname : String = self.fullNameTextField.text!
        
        let parameter1 : Parameters  = ["email_id" : username , "password": password, "uname":Fullname] as Parameters
        
        Alamofire.request("http://mshmsh.tv/signUp.php", method: .post, parameters: parameter1, headers: nil)
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let type : String = dict.value(forKeyPath: "Response.data.type") as! String
                    let message: String = dict.value(forKeyPath: "Response.data.message") as! String
                    if type == "Success" {
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
