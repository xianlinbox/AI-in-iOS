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
}

//MARK: barcode reading
extension VisionUtils {
    
    static func detectBarcode(image:UIImage, completion:@escaping (String) -> Void){
        let imageDetectRequest = createBarcodeReadRequest(completion)
        do {
            let ciImage = CIImage(image: image)
            try VNImageRequestHandler(ciImage: ciImage!, options:[:]).perform([imageDetectRequest])
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    private static func createBarcodeReadRequest(_ completion:@escaping (String) -> Void) -> VNImageBasedRequest {
        return VNDetectBarcodesRequest(completionHandler: { request, error in
            guard let results = request.results as? [VNBarcodeObservation] else {
                print("!!!!!!!!!!something bad happens!!!")
                return
            }
            if let barcode = results.first {
                completion(barcode.payloadStringValue!)
            }
            
        })
    }
}

