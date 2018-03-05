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
        VisionUtils.detectImage(detectType: VisionConstants.faceRecog, image: self.imageView.image!) { (faceMarks) in
            for mark in faceMarks {
                self.imageView.addSubview(self.createBoxView(frame: ViewUtils.scaleFrame(mark.cgRectValue, self.imageView!.frame)))
            }
        }
    }

    private func createBoxView(frame: CGRect) -> UIView {
        let boxView = UIView(frame: frame)
        boxView.backgroundColor = UIColor.clear
        boxView.layer.borderColor = UIColor.red.cgColor
        boxView.layer.borderWidth = 2
        return boxView
    }
}
