//
//  CoreMLUtils.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 13/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Vision
import UIKit

struct CoreMLUtils {
    static func detectImage(image: UIImage, completion:@escaping([VNClassificationObservation]) -> Void) {

        guard let model = try? VNCoreMLModel(for: SqueezeNet().model) else { fatalError("This model can't be applied to CoreML") }

        let imageDetectRequest = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else { fatalError("unexpected result type from VNCoreMLRequest") }
            completion(results)
        }
        do {
            let detectImage = CIImage(image: image)
            try VNImageRequestHandler(ciImage: detectImage!, options: [:]).perform([imageDetectRequest])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
