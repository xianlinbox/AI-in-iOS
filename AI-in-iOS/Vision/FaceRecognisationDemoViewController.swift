//
//  FaceRecognisationDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

class FaceRecognisationDemoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var changeImageButton:UIButton!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    @IBAction func pickImageFromLib() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shootPhotoByCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.noCameraAlert()
        }
    }
    
    private func noCameraAlert() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: ImagePicker Delegate
extension FaceRecognisationDemoViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        clearOldSubViews();
        let newImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let ratio = newImage.size.height/newImage.size.width
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.width * ratio))
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = newImage
        self.view.addSubview(self.imageView)
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            VisionUtils.detectImage(image: newImage) { (faceMarks) in
                for mark in faceMarks {
                    self.imageView.addSubview(self.createBoxView(frame: self.scaleFrame(mark.cgRectValue)))
                }
            }
        }
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func clearOldSubViews() {
        for subView in self.imageView.subviews {
            subView.removeFromSuperview()
        }
        self.imageView?.removeFromSuperview()
    }
    private func scaleFrame(_ originFrame:CGRect) -> CGRect{
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.imageView!.frame.size.height)
        let translate = CGAffineTransform.identity.scaledBy(x: self.imageView!.frame.size.width, y: self.imageView!.frame.size.height)
        return originFrame.applying(translate).applying(transform)
    }
    
    private func createBoxView(frame:CGRect) -> UIView{
        let boxView = UIView(frame: frame)
        boxView.backgroundColor = UIColor.clear
        boxView.layer.borderColor = UIColor.red.cgColor
        boxView.layer.borderWidth = 2
        return boxView
    }
}

