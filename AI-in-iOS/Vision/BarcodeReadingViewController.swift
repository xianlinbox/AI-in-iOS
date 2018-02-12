//
//  BarcodeReadingViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 12/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Vision

class BarcodeAnaylysisViewController: ImageAnalysisBaseViewController {
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addTextArea();
    }
    
    override func performAnalysis() {
    }
    
    private func addTextArea() {
        self.textView?.removeFromSuperview()
        let imageViewFrame = self.imageView.frame
        textView = UITextView(frame: CGRect(x: imageViewFrame.origin.x + 10, y: imageViewFrame.origin.y + imageViewFrame.size.height + 20, width: imageViewFrame.size.width-20, height: 100))
        textView.textColor = UIColor.red
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        self.view.addSubview(textView)
    }
}
