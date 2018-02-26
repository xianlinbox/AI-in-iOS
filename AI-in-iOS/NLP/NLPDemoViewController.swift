//
//  NLPDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 14/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Speech
class NLPDemoViewController: UIViewController {
    var textView:UITextView!
    var recordButton:UIButton!
    var localeTextField:UITextField!
    let supportLocales = Array(SFSpeechRecognizer.supportedLocales())
    var selectedLocale:Locale?
    
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
        addPickerView()
        addToolbar()
        checkAuthorisationStatus()
    }
    
    @objc func recordButtonTapped(){
        print("record button tapped .........")
    }
    
    fileprivate func checkAuthorisationStatus() {
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
    
    fileprivate func addPickerView() {
        localeTextField = UITextField(frame: CGRect(x: UIConstants.SCREEN_WIDTH/2 - 100, y: UIConstants.SCREEN_HEIGHT - 50, width: 200, height: 30))
        localeTextField.borderStyle = .roundedRect
        localeTextField.layer.borderColor = UIColor.black.cgColor
        localeTextField.layer.borderWidth = 2
        let localePicker = UIPickerView()
        localePicker.delegate = self
        localePicker.dataSource = self
        localeTextField.inputView = localePicker
        self.view.addSubview(localeTextField)
    }
    
    fileprivate func addToolbar(){
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        localeTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

//MARK: SFSpeechRecoginizerDelegate
extension NLPDemoViewController:SFSpeechRecognizerDelegate {
    
}

//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension NLPDemoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return supportLocales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return supportLocales[row].identifier
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLocale = supportLocales[row]
        localeTextField.text = selectedLocale?.identifier
    }
}

