//
//  VisionUtils.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 05/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Vision
import UIKit

struct VisionUtils {
    
    static func detectImage(detectType:String, image:UIImage, completion:@escaping ([NSValue]) -> Void){
        var imageDetectRequest:VNImageBasedRequest!
        switch detectType {
        case FACE_RECOG:
            imageDetectRequest = createFaceRecogRequest(completion)
        case FACE_LANDMARKS:
            imageDetectRequest = createFaceLandmarksRequest(completion)
        case BARCODE_READ:
            imageDetectRequest = createBarcodeReadRequest(completion)
        default:
            break
        }
        
        do {
            let ciImage = CIImage(image: image)
            try VNImageRequestHandler(ciImage: ciImage!, options:[:]).perform([imageDetectRequest])
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    fileprivate static func createFaceRecogRequest(_ completion: @escaping ([NSValue]) -> Void) -> VNImageBasedRequest {
        return VNDetectFaceRectanglesRequest { (request, error) in
            guard let observations = request.results as? [VNFaceObservation] else {
                fatalError("The Face detect results is not match!")
            }
            markFaces(faces: observations, completion: completion)
        }
    }
    
    private static func markFaces(faces:[VNFaceObservation], completion:([NSValue]) -> Void) {
        var faceMarks:[NSValue] = [];
        for face in faces {
            let faceData = NSValue(cgRect: face.boundingBox)
            faceMarks.append(faceData)
        }
        completion(faceMarks)
    }
    
    fileprivate static func createFaceLandmarksRequest(_ completion:([NSValue]) -> Void) -> VNImageBasedRequest{
        return VNDetectFaceLandmarksRequest(completionHandler: { (request, error) in
            guard let observations = request.results as? [VNFaceObservation] else {
                fatalError("The Face detect results is not match!")
            }
            let faceLandmarks = NSObject();
            for face in  observations {
                let landMarks = face.landmarks
                for (name,value) in Mirror(reflecting: landMarks!).children {
                    if (name != "allppoints") {
                        faceLandmarks.setValue(value, forKey: name!)
                    }
                }
            }
        })
    }
    
    private static func createBarcodeReadRequest(_ completion:([NSValue]) -> Void) -> VNImageBasedRequest {
        return VNDetectBarcodesRequest(completionHandler: { request, error in
//            guard let results = request.results else { return }
//
//            // Loopm through the found results
//            for result in results {
//
//                // Cast the result to a barcode-observation
//                if let barcode = result as? VNBarcodeObservation {
//
//                    // Print barcode-values
//                    print("Symbology: \(barcode.symbology.rawValue)")
//
//                    if let desc = barcode.barcodeDescriptor as? CIQRCodeDescriptor {
//                        let content = String(data: desc.errorCorrectedPayload, encoding: .utf8)
//
//                        // FIXME: This currently returns nil. I did not find any docs on how to encode the data properly so far.
//                        print("Payload: \(String(describing: content))")
//                        print("Error-Correction-Level: \(desc.errorCorrectionLevel)")
//                        print("Symbol-Version: \(desc.symbolVersion)")
//                    }
//                }
//            }
        })
    }
}

