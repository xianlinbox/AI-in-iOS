//
//  ClassificationViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 13/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Vision

class ClassificationViewController: ImageAnalysisBaseViewController {
  var textView: UITextView!
  var usingFirebaseLabel: UILabel!
  var firebaseSwitch: UISwitch!
  override func viewWillAppear(_ animated: Bool) {
    addFirebaseSwitch()
    addTextArea()
  }
  override func performAnalysis() {
    CoreMLUtils.detectImage(image: self.imageView.image!) { (results) in
      var text = ""
      let top3 = results[0...2]
      for result in top3 {
        text += String(format: "%.2f", result.confidence * 100) + "% : " + result.identifier + "\n"
      }
      self.textView.text = text
    }
  }
  private func addFirebaseSwitch() {
    let imageViewFrame = self.imageView.frame
    usingFirebaseLabel = UILabel(frame: CGRect(x: imageViewFrame.origin.x + 10,
                                        y: imageViewFrame.origin.y + imageViewFrame.size.height + 20,
                                        width: 200,
                                        height: 30))
    usingFirebaseLabel.textColor = UIColor.black
    usingFirebaseLabel.text = "Using Firebase:"
    self.view.addSubview(usingFirebaseLabel)
    firebaseSwitch = UISwitch(frame: CGRect(x: imageViewFrame.origin.x + 220 ,
      y: imageViewFrame.origin.y + imageViewFrame.size.height + 20,
      width: 100,
      height: 30))
     self.view.addSubview(firebaseSwitch)
  }
  private func addTextArea() {
    self.textView?.removeFromSuperview()
    let imageViewFrame = self.imageView.frame
    textView = UITextView(frame: CGRect(x: imageViewFrame.origin.x + 10,
                                        y: imageViewFrame.origin.y + imageViewFrame.size.height + 70,
                                        width: imageViewFrame.size.width-20,
                                        height: 100))
    textView.textColor = UIColor.red
    textView.layer.borderColor = UIColor.black.cgColor
    textView.layer.borderWidth = 1
    self.view.addSubview(textView)
  }
}
