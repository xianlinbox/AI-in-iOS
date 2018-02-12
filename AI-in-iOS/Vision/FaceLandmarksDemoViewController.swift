//
//  FaceRecognisationDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit
import Vision

class FaceLandmarksDemoViewController: ImageAnalysisBaseViewController {
 
    override func performAnalysis() {
        VisionUtils.detectImage(detectType: FACE_LANDMARKS, image: self.imageView.image!, completion: { (result) in
            
        })
    }
}


