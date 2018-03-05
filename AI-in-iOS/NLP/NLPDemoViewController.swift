//
//  NLPDemoViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 14/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Speech
import AVKit
class NLPDemoViewController: UIViewController {
    var textView: UITextView!
    var recordButton: UIButton!
    var localeTextField: UITextField!
    let supportLocales = Array(SFSpeechRecognizer.supportedLocales())
    var selectedLocale: Locale = Locale(identifier: "en_US")
    let audioEngine = AVAudioEngine()
    var speechRecognitionTask: SFSpeechRecognitionTask?
    lazy var speechRecoginizer: SFSpeechRecognizer? = {
        if let recoginiser = SFSpeechRecognizer(locale: selectedLocale) {
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

    @objc func recordButtonTapped() throws {
        print("record button tapped .........")
        if let recognitionTask = self.speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        let request = SFSpeechAudioBufferRecognitionRequest()
        let node = audioEngine.inputNode
        request.shouldReportPartialResults = true
        speechRecognitionTask = speechRecoginizer?.recognitionTask(with: request) { (result, error) in
            var isFinal = false
            if let result = result {
                let sentence = result.bestTranscription.formattedString
                self.textView.text = sentence
                isFinal = result.isFinal
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                self.speechRecognitionTask = nil
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Start Recording", for: [])
            }
        }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        textView.text = "(Go Ahead, I'm listening...)"
    }

    fileprivate func checkAuthorisationStatus() {
        SFSpeechRecognizer.requestAuthorization { (status: SFSpeechRecognizerAuthorizationStatus) in
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
        textView = UITextView(frame: CGRect(x: 10, y: 100, width: UIConstants.screenWidth - 20, height: 600))
        textView.textColor = UIColor.red
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        self.view.addSubview(textView)
    }

    fileprivate func addRecordButton() {
        recordButton = UIButton(frame: CGRect(x: UIConstants.screenWidth/2 - 100, y: UIConstants.screenHeight - 100, width: 200, height: 30))
        recordButton.setTitle("Start voice recording", for: .normal)
        recordButton.backgroundColor=UIColor.blue
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        self.view.addSubview(recordButton)
    }

    fileprivate func addPickerView() {
        localeTextField = UITextField(frame: CGRect(x: UIConstants.screenWidth/2 - 100, y: UIConstants.screenHeight - 50, width: 200, height: 30))
        localeTextField.borderStyle = .roundedRect
        localeTextField.layer.borderColor = UIColor.black.cgColor
        localeTextField.layer.borderWidth = 2
        let localePicker = UIPickerView()
        localePicker.delegate = self
        localePicker.dataSource = self
        localeTextField.inputView = localePicker
        self.view.addSubview(localeTextField)
    }

    fileprivate func addToolbar() {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        localeTextField.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: SFSpeechRecoginizerDelegate
extension NLPDemoViewController: SFSpeechRecognizerDelegate {

}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
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
        localeTextField.text = selectedLocale.identifier
    }
}
