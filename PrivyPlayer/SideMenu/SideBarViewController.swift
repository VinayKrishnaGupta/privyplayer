//
//  SideBarViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView


class SideBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableView: UITableView!
    var MenuItems = Array<String>()
    var SignINButtonName = String()
//    let MenuItemsImageNames = ["home_service_final","visa_services_final","passport_final","immigration_final","airport_services_final","attestations_final","student_services_final","about_us", "track_application_final", "immigration_final"]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        if (UserDefaults.standard.value(forKey: "UserID") != nil) {
            let userID = UserDefaults.standard.value(forKey: "UserID") as? String
            if (userID == "0")
            {
                self.SignINButtonName = "Sign In"
            }
            else
            {
                self.SignINButtonName = "Sign Out"
            }
        }
        else
        {
            self.SignINButtonName = "Sign In"
        }
        self.MenuItems = ["Home","Search Video", "Liked Videos", "Recently Uploaded","Request A Video","Upload Video","My Profile",SignINButtonName]
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuItems.count
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = MenuItems[indexPath.section]
        
        
      //  cell.imageView?.image = UIImage.init(named: MenuItemsImageNames[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            
            sideMenuController?.performSegue(withIdentifier: "Home", sender: nil)
        }
            
        else if indexPath.section == 1 {
            //SearchVC
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
           // self.navigationController?.pushViewController(vc, animated: true)
          //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            aObjNavi.navigationItem.title = "Search"
            aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.present(aObjNavi, animated: true, completion: nil)
        }
        
        else if indexPath.section == 2 {
            //SearchVC
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LikedVideoVC")
            // self.navigationController?.pushViewController(vc, animated: true)
            //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            aObjNavi.navigationItem.title = "Liked Video"
            aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.present(aObjNavi, animated: true, completion: nil)
        }
        else if indexPath.section == 3 {
            //SearchVC
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "recentUploadVC")
            // self.navigationController?.pushViewController(vc, animated: true)
            //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            aObjNavi.navigationItem.title = "Recent Uploads"
            aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.present(aObjNavi, animated: true, completion: nil)
        }
        else if indexPath.section == 4 {
            //SearchVC
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "requestVideoVC")
            // self.navigationController?.pushViewController(vc, animated: true)
            //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
            let aObjNavi = UINavigationController(rootViewController: vc)
            aObjNavi.navigationBar.isTranslucent = false
            aObjNavi.navigationBar.tintColor = UIColor.white
            aObjNavi.navigationItem.title = "Request Videos"
            aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            self.present(aObjNavi, animated: true, completion: nil)
        }
        
        else if indexPath.section == 7 {
            //SearchVC
            if SignINButtonName == "Sign In" {
                let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SignINVC")
                // self.navigationController?.pushViewController(vc, animated: true)
                //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
                let aObjNavi = UINavigationController(rootViewController: vc)
                aObjNavi.navigationBar.isTranslucent = false
                aObjNavi.navigationBar.tintColor = UIColor.white
                aObjNavi.navigationItem.title = "gig.gs"
                aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                self.present(aObjNavi, animated: true, completion: nil)
            }
            else {
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                let storyboard = UIStoryboard.init(name: "Auth", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SignINVC")
                // self.navigationController?.pushViewController(vc, animated: true)
                //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
                let aObjNavi = UINavigationController(rootViewController: vc)
                aObjNavi.navigationBar.isTranslucent = false
                aObjNavi.navigationBar.tintColor = UIColor.white
                aObjNavi.navigationItem.title = "gig.gs"
                aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                self.present(aObjNavi, animated: true, completion: nil)
            }
            
        }
            
        else if indexPath.section == 5 {
           //UploadVideoVC
            DispatchQueue.global(qos: .userInitiated).async {
                let userID = UserDefaults.standard.value(forKey: "UserID") as? String
                if (userID == "0")
                {
                    print("You Are Not Logged In")
                    DispatchQueue.main.async
                        {
                            SCLAlertView().showError("Guest", subTitle: "You Are not Logged In, Please Login")
                    }
                    return
                }
                DispatchQueue.main.async
                    {
                        let storyboard = UIStoryboard.init(name: "UploadVideos", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "UploadVideoVC")
                        // self.navigationController?.pushViewController(vc, animated: true)
                        //  sideMenuController?.navigationController?.pushViewController(vc, animated: true)
                        let aObjNavi = UINavigationController(rootViewController: vc)
                        aObjNavi.navigationBar.isTranslucent = false
                        aObjNavi.navigationBar.tintColor = UIColor.white
                        aObjNavi.navigationItem.title = "Upload Video"
                        aObjNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                        self.present(aObjNavi, animated: true, completion: nil)
                }
            }
            
        }
        
        else {
            DispatchQueue.global(qos: .userInitiated).async {
                let userID = UserDefaults.standard.value(forKey: "UserID") as? String
                if (userID == "0")
                {
                    print("You Are Not Logged In")
                    DispatchQueue.main.async
                        {
                            SCLAlertView().showError("Guest", subTitle: "You Are not Logged In, Please Login")
                    }
                    return
                }
                DispatchQueue.main.async
                    {
                        SCLAlertView().showInfo("Coming Soon", subTitle: "Currently, This Feature is Not Available")
                }
            }
        }
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

