//
//  VisionUtilsTests.swift
//  AI-in-iOSTests
//
//  Created by Xianning Liu  on 12/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import Quick
import Nimble

class VisionUtilsSpecs: QuickSpec {
    override func spec() {
        describe("VisionUtils") {
            it("should read infomation from qrcode"){
                let testImage = UIImage(named: "QRCode")
                VisionUtils.detectBarcode(image: testImage!) { (result) in
                    expect(result).to(equal("http://en.m.wikipedia.org"))
                }
            }
        }
    }
}
