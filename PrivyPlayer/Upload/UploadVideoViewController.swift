//
//  UploadVideoViewController.swift
//  PrivyPlayer
//
//  Created by RSTI E-Services on 23/02/18.
//  Copyright © 2018 RSTI E-Services. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import SCLAlertView

class UploadVideoViewController: UIViewController {

    @IBOutlet var fileTitleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var qualityTextFeld: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var totalDurationTextField: UITextField!
    
    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 200/256, green: 54/256, blue: 54/256, alpha: 1)
        let backButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "Back_Button"), style: UIBarButtonItemStyle.done, target: self, action: #selector(BackButtonmethod))
        self.navigationItem.leftBarButtonItem = backButton
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationItem.title = "Upload Video"
       
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func BackButtonmethod() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func SelectVideoButton(_ sender: UIButton)
    {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as NSString as String,kUTTypeMPEG4 as NSString as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func SelectImageButton(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as NSString as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    
   
    @IBAction func SubmitButton(_ sender: UIButton)
    {
        self.UploadVideo()
    }
    
    func UploadVideo()
    {
        if (fileTitleTextField.text?.isEmpty)! || (descriptionTextField.text?.isEmpty)! || (totalDurationTextField.text?.isEmpty)! ||
            (categoryTextField.text?.isEmpty)! || (qualityTextFeld.text?.isEmpty)! || (imageURL == nil) || (videoURL == nil){
            SCLAlertView().showError("Error", subTitle: "All Fields including Video and Image are mandetory")
            return
        }
        print(String(describing: videoURL))
        
        let userID = UserDefaults.standard.value(forKey: "UserID") as? String
        if (userID == "0") {
            print("You Are Not Logged In")
            DispatchQueue.main.async
                {
                    SCLAlertView().showError("Guest", subTitle: "You Are not Logged In, Please Login to use this feature")
            }
            return
        }
         SCLAlertView().showWait("Uploading, Please Wait", subTitle: "Do not press back button, it will cancel the upload")
       // let fileURL = Bundle.main.url(forResource: videoURL, withExtension: "mov")
        
//        Alamofire.upload(videoURL!, to: "http://gig.gs/API_V2/API/uploadVideosAPI").responseJSON { response in
//            debugPrint(response)
//        }
        let url = "http://gig.gs/API_V2/API/uploadVideosAPI?fileType=2&fileTitle=\(fileTitleTextField.text!)&description=\(descriptionTextField.text!)&quality=4&category=25&duration=\(totalDurationTextField.text!)&userId=\(userID!)"
       
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(self.videoURL!, withName: "uploadFile")
                multipartFormData.append(self.imageURL!, withName: "uploadImage")
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    SCLAlertView().showSuccess("Successfully Uploaded", subTitle: "We will review in next 48 hours")
                    self.videoURL = nil
                    self.imageURL = nil
                    self.qualityTextFeld.text = ""
                    self.fileTitleTextField.text = ""
                    self.categoryTextField.text = ""
                    self.descriptionTextField.text = ""
                    self.totalDurationTextField.text = ""
                    
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    SCLAlertView().showError("Uploading Failed", subTitle: "Please Try Again Later")
                }
        }
        )
        
//        Alamofire.request("http://gig.gs/API_V2/API/uploadVideosAPI", method: .post, parameters: parameter,encoding: JSONEncoding.default, headers:nil)
//            .responseJSON { response in
//                debugPrint(response)
//
//
//                if let json = response.result.value {
//                    let dict = json as! NSDictionary
//                    print(dict)
//                    let type : String = dict.value(forKeyPath: "status.type") as! String
//                    if type == "Success"
//                    {
//
//
//                    }
//                    else
//                    {
//                        print("No Video found")
//
//                    }
//                }
//                else {
//
//                    print("Error")
//                }
//
//        }
//
        
        
        
        
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
extension UploadVideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if videoURL == nil {
             videoURL = info[UIImagePickerControllerMediaURL] as? URL
            print("videoURL:\(String(describing: videoURL))")
        }
        else {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let imageUrl          = info[UIImagePickerControllerReferenceURL] as? NSURL
            let imageName         = imageUrl?.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
            let localPath         = photoURL.appendingPathComponent(imageName!)
            
           
                do {
                    try UIImageJPEGRepresentation(image, 1.0)?.write(to: localPath!)
                    print("file saved")
                    imageURL = localPath
                }catch {
                    print("error saving file")
                }
           
           
            print("ImageURL:\(String(describing: imageURL))")
          
        }
       
        print("videoURL:\(String(describing: videoURL))")
        self.dismiss(animated: true, completion: nil)
    }
}

