//
//  FaceRecognisationDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

class ImageAnalysisBaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageView: UIImageView!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.addButtons()
        self.reloadImage(newImage: nil)
    }

    func addButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(shootPhotoByCamera))
        let changeButton = UIButton(frame: CGRect(x: UIConstants.screenWidth/2 - 100, y: UIConstants.screenHeight - 100, width: 200, height: 30))
        changeButton.setTitle("Choose Another Image", for: .normal)
        changeButton.backgroundColor=UIColor.blue
        changeButton.addTarget(self, action: #selector(pickImageFromLib), for: .touchUpInside)
        self.view.addSubview(changeButton)
    }

    func performAnalysis() {
        print("*******************")
        print("Please implement the perform Analysis method!")
        print("*******************")
    }

    func reloadImage(newImage: UIImage?) {
        let imageToDetect = newImage ?? UIImage(named: "twer")
        if let image = imageToDetect {
            ViewUtils.clearOldSubViews(view: self.imageView)
            self.updateImageView(image)
        }
        DispatchQueue.main.async {
            self.performAnalysis()
        }
    }
    @objc func pickImageFromLib() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(imagePicker, animated: true, completion: nil)
    }

    @objc func shootPhotoByCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
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
            style: .default,
            handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: ImagePicker Delegate
extension ImageAnalysisBaseViewController {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
      if let newImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        self.reloadImage(newImage: newImage)
        dismiss(animated: true, completion: nil)
      }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    fileprivate func updateImageView(_ newImage: UIImage) {
        self.imageView?.removeFromSuperview()
        let ratio = newImage.size.height/newImage.size.width
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.width * ratio))
        self.imageView.image = newImage
        self.view.addSubview(self.imageView)
    }

    private func scaleFrame(_ originFrame: CGRect) -> CGRect {
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.imageView!.frame.size.height)
        let translate = CGAffineTransform.identity.scaledBy(x: self.imageView!.frame.size.width, y: self.imageView!.frame.size.height)
        return originFrame.applying(translate).applying(transform)
    }

    private func createBoxView(frame: CGRect) -> UIView {
        let boxView = UIView(frame: frame)
        boxView.backgroundColor = UIColor.clear
        boxView.layer.borderColor = UIColor.red.cgColor
        boxView.layer.borderWidth = 2
        return boxView
    }
}
