//
//  DynamicTrackViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 17/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import AVKit
class RealtimeAddonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCameraAuthorisation()
    }
    
    private func getCameraAuthorisation() {
        let vedioStatua = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch vedioStatua {
        case .denied,
             .restricted:
            showWarningMessage()
        default:
            initCapture()
        }
    }
    
    private func showWarningMessage() {
        
    }
    
    private func initCapture() {
        
    }
    
}
