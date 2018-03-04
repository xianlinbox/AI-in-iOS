//
//  ViewUtils.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 20/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit

struct ViewUtils {
    static func scaleFrame(_ originFrame: CGRect, _ newFrame: CGRect ) -> CGRect {
        let imageFrameSize = newFrame.size
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imageFrameSize.height)
        let translate = CGAffineTransform.identity.scaledBy(x: imageFrameSize.width, y: imageFrameSize.height)
        return originFrame.applying(translate).applying(transform)
    }

    static func clearOldSubViews(view: UIView?) {
        if let subViews = view?.subviews {
            for subView in subViews {
                subView.removeFromSuperview()
            }
        }
    }
}
