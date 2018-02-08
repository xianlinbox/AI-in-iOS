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
    
    static func detectImage(image:UIImage, completion:@escaping ([NSValue]) -> Void){
        let ciImage = CIImage(image: image)
        let faceDetectRequest = VNDetectFaceRectanglesRequest { (request, error) in
            guard let observations = request.results as? [VNFaceObservation] else {
                fatalError("The Face detect results is not match!")
            }
            markFaces(faces: observations, completion: completion)
        }
        let requestHandler = VNImageRequestHandler(ciImage: ciImage!, options:[:])
        do {
            try requestHandler.perform([faceDetectRequest])
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    static func markFaces(faces:[VNFaceObservation], completion:([NSValue]) -> Void) {
        var faceMarks:[NSValue] = [];
        for face in faces {
            let faceData = NSValue(cgRect: face.boundingBox)
            faceMarks.append(faceData)
        }
        completion(faceMarks)
    }
}

