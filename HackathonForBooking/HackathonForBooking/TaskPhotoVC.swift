//
//  TaskPhotoVC.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit
import MobileCoreServices

class TaskPhotoVC: UIViewController {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskContent: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var imgTask: UIImageView!
    
    var isNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Please Choose", message: "Provide One Photo", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { [weak self] (action) in
            if let weakSelf = self {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imgPicker = UIImagePickerController()
                    imgPicker.delegate = weakSelf
                    imgPicker.allowsEditing = false
                    imgPicker.sourceType = .camera
                    imgPicker.cameraCaptureMode = .photo
                    imgPicker.modalPresentationStyle = .fullScreen
                    imgPicker.mediaTypes = [kUTTypeImage as String]
                    weakSelf.present(imgPicker, animated: true, completion: nil)
                    weakSelf.isNew = true
                }
            }
        })
        
        let cameraRollAction = UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] (action) in
            if let weakSelf = self {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imgPicker = UIImagePickerController()
                    imgPicker.delegate = weakSelf
                    imgPicker.allowsEditing = false
                    imgPicker.sourceType = .photoLibrary
                    imgPicker.mediaTypes = [kUTTypeImage as String]
                    imgPicker.modalPresentationStyle = .popover
                    weakSelf.present(imgPicker, animated: true,
                                 completion: nil)
                    weakSelf.isNew = false
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cameraRollAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func finish(_ sender: Any) {
    }
    
}

extension TaskPhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            self.imgTask.image = image
            
            if (self.isNew == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(TaskPhotoVC.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel,
                                             handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
}