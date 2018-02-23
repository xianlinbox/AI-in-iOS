//
//  NLPDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 14/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Speech
class NLPDemoViewController: UIViewController, SFSpeechRecognizerDelegate {
    var textView:UITextView!
    var recordButton:UIButton!
    
    lazy var speechRecoginizer:SFSpeechRecognizer? = {
        if let recoginiser = SFSpeechRecognizer(locale: Locale(identifier: "en_US")){
            recoginiser.delegate = self
            return recoginiser
        } else {
            return nil
        }
    }()
    
    
    override func viewDidLoad() {
        addTextArea()
        addRecordButton()
        checkAuthorisationStatus()
    }
    
    @objc func recordButtonTapped(){
        print("record button tapped .........")
    }
    
    fileprivate func checkAuthorisationStatus() {
        let locales = SFSpeechRecognizer.supportedLocales()
        print(locales)
        SFSpeechRecognizer.requestAuthorization { (status:SFSpeechRecognizerAuthorizationStatus) in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    self.recordButton.isEnabled = true
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
        
    }
    
    fileprivate func addTextArea() {
        self.textView?.removeFromSuperview()
        textView = UITextView(frame: CGRect(x: 10, y: 100, width: UIConstants.SCREEN_WIDTH - 20, height: 600))
        textView.textColor = UIColor.red
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        self.view.addSubview(textView)
    }
    
    fileprivate func addRecordButton() {
        recordButton = UIButton(frame: CGRect(x: UIConstants.SCREEN_WIDTH/2 - 100, y: UIConstants.SCREEN_HEIGHT - 100, width: 200, height: 30))
        recordButton.setTitle("Start voice recording", for: .normal)
        recordButton.backgroundColor=UIColor.blue
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        self.view.addSubview(recordButton)
    }
    
}

//MARK: SFSpeechRecoginizerDelegate
extension NLPDemoViewController {
    
}

