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
        var faceDetectRequest:VNImageBasedRequest!
        switch detectType {
        case FACE_RECOG:
            faceDetectRequest = createFaceRecogRequest(completion)
        case FACE_LANDMARKS:
            faceDetectRequest = createFaceLandmarksRequest(completion)
        default:
            break
        }
        
        do {
            let ciImage = CIImage(image: image)
            try VNImageRequestHandler(ciImage: ciImage!, options:[:]).perform([faceDetectRequest])
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
            var faceLandmarks:[NSValue] = [];
            for face in  observations {
                let landMarks = face.landmarks
                for (name,value) in Mirror(reflecting: landMarks!).children {
                    if (name != "allppoints") {}
                }
            }
        })
    }
}

