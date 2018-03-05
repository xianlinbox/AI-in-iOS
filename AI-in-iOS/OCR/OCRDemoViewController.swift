//
//  OCRDemosViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 22/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

class OCRDemoViewController: ImageAnalysisBaseViewController {
    var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadImage(newImage: UIImage(named: "OCRText"))
    }

    override func viewWillAppear(_ animated: Bool) {
        addTextArea()
    }

    override func performAnalysis() {
        OCRUtils.recogText(image: self.imageView.image!) { (result) in
            self.textView.text = result
        }
    }

    private func addTextArea() {
        self.textView?.removeFromSuperview()
        let imageViewFrame = self.imageView.frame
        textView = UITextView(frame: CGRect(x: imageViewFrame.origin.x + 10,
                                            y: imageViewFrame.origin.y + imageViewFrame.size.height + 10,
                                            width: imageViewFrame.size.width-20,
                                            height: 200))
        textView.textColor = UIColor.red
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        self.view.addSubview(textView)
    }
}
