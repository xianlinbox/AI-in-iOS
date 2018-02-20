//
//  DynamicTrackViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 17/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import AVKit
import Vision
class RealtimeAddonViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var session:AVCaptureSession!
    var previewLayer:AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCameraAuthorisation()
    }
    
    private func getCameraAuthorisation() {
        let vedioStatua = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch vedioStatua {
        case .denied,
             .restricted:
            showWarningMessage()
        default:
            initCapture()
        }
    }
    
    private func showWarningMessage() {
        let alertView = UIAlertController(title: "Camera is not authorised", message: "Please go to settings > privacy -> Camera to open the priviledge", preferredStyle: .actionSheet)
        let defaultActipn = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(defaultActipn)
        self.present(alertView, animated: true, completion: nil)
    }
    
    private func initCapture() {
        session = AVCaptureSession()
        let device = AVCaptureDevice.default(for: .video)
        do{
            let deviceInput = try AVCaptureDeviceInput(device: device!)
            session.addInput(deviceInput)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        session.addOutput(deviceOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        self.view.layer.addSublayer(previewLayer)
        self.session.startRunning()
    }
}

//MARK: AVCaptureVideoDataOutputSampleBufferDelegate
extension RealtimeAddonViewController {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
        let cvPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer!, options: [:])
        let faceDetectReq = VNDetectFaceRectanglesRequest()
        do {
            try requestHandler.perform([faceDetectReq])
        }catch{
            fatalError(error.localizedDescription)
        }
        
        if let results = faceDetectReq.results as? [VNFaceObservation] {
            DispatchQueue.main.async {
                self.handleFaceDetectResults(results)
            }
        }
    }
    
    private func handleFaceDetectResults(_ result:[VNFaceObservation]) {
        for observation in result {
            let ratioRect = observation.boundingBox
            let realRect = ViewUtils.scaleFrame(ratioRect, self.view.bounds)
            let hatY = realRect.origin.y - realRect.size.height
            let hatRect = CGRect(origin: CGPoint(x: realRect.origin.x, y: hatY), size: realRect.size)
            let hatImageView = UIImageView(image: UIImage(named: "hat"))
            hatImageView.frame = hatRect
            self.view.addSubview(hatImageView)
        }
    }
}

