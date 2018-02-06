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
            markFaces(image: image, faces: observations, completion: completion)
        }
        let requestHandler = VNImageRequestHandler(ciImage: ciImage!, options:[:])
        do {
            try requestHandler.perform([faceDetectRequest])
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
    static func markFaces(image:UIImage, faces:[VNFaceObservation], completion:([NSValue]) -> Void) {
        var faceMarks:[NSValue] = [];
        for face in faces {
            let bounds = face.boundingBox
            let faceRect = convertRect(bounds, imageSize: image.size)
            let faceData = NSValue(cgRect: faceRect)
            faceMarks.append(faceData)
        }
        completion(faceMarks)
    }
    
    private static func convertRect(_ oldRect:CGRect, imageSize: CGSize) -> CGRect{
        let w = oldRect.size.width * imageSize.width
        let h = oldRect.size.height * imageSize.height
        let x = oldRect.origin.x * imageSize.width
        let y = imageSize.height - (oldRect.origin.y * imageSize.height) - h
        return CGRect(x: x, y: y, width: w, height: h)
    }
}

