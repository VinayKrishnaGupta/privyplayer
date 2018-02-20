//
//  SideBarViewController.swift
//  RST Simplified
//
//  Created by RSTI E-Services on 27/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD


class SideBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableView: UITableView!
    let MenuItems = ["Home","Search", "Upload Videos", "Recently Uploaded", "Popular Hits","Request A Video", "Contact Us"]
//    let MenuItemsImageNames = ["home_service_final","visa_services_final","passport_final","immigration_final","airport_services_final","attestations_final","student_services_final","about_us", "track_application_final", "immigration_final"]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        
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
     
        else {
            SVProgressHUD.show(withStatus: "Coming Soon...")
            SVProgressHUD.dismiss(withDelay: 2)
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

