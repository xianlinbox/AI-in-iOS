//
//  OCRUtils.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 01/03/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Foundation
import TesseractOCR

struct OCRUtils {
    static func recogText(image: UIImage, _ completion: (String) -> Void) {

        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .auto
            tesseract.image = image.g8_blackAndWhite()
            if tesseract.recognize() {
              completion(tesseract.recognizedText)
            } else {
                print("*******Unable to recog *********")
            }
        }
    }
}
