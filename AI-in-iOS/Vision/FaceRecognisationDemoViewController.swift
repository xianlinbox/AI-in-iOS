//
//  FaceRecognisationDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

class FaceRecognisationDemoViewController: ImageAnalysisBaseViewController {
    
    override func performAnalysis() {
        VisionUtils.detectImage(detectType:FACE_RECOG, image: self.imageView.image!) { (faceMarks) in
            for mark in faceMarks {
                self.imageView.addSubview(self.createBoxView(frame: self.scaleFrame(mark.cgRectValue)))
            }
        }
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

