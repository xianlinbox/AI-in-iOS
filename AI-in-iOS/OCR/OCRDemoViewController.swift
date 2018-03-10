//
//  OCRDemosViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 22/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit
import SnapKit

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
    textView = UITextView()
    self.view.addSubview(textView)
    textView.snp.makeConstraints { (constraints) in
      constraints.width.equalTo(self.imageView)
      constraints.left.right.equalTo(self.imageView)
      constraints.top.equalTo(self.imageView.snp.bottom).offset(10)
      constraints.height.equalTo(200)
    }
  }
}
