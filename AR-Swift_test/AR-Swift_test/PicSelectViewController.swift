//
//  PicSelectController.swift
//  ARImg
//
//  Created by sxy on 11/21/19.
//  Copyright © 2019 sxy. All rights reserved.
//

import UIKit
import SceneKit
import ARKit


class PicSelectController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.btnChoosePic.layer.cornerRadius = 5
//        self.btnGotoAR.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var btnChoosePic: UIButton!
    
    @IBOutlet weak var btnGotoAR: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func btnGotoAR(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
              let ArtTreeView = story.instantiateViewController(withIdentifier: "ViewControllerID")
              let vc = ArtTreeView as! ViewController
              vc.arIndex = 1
              self.navigationController?.pushViewController(ArtTreeView, animated: true)
    }
    
    @IBAction func btnChoosePic(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.present(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
 extension PicSelectController:
    UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imgPreview.image = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }

}
