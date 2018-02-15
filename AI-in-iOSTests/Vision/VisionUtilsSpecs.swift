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
                waitUntil(timeout: 2) { done in
                    VisionUtils.detectBarcode(image: testImage!) { (result) in
                        expect(result).to(equal("http://en.m.wikipedia.org"))
                        done()
                    }
                }
            }
            
            it("should read infomation from EAN13barcode"){
                let testImage = UIImage(named: "EAN13barcode", in: Bundle(for: VisionUtilsSpecs.self), compatibleWith: nil)
                waitUntil(timeout: 2){ done in
                    VisionUtils.detectBarcode(image: testImage!) { (result) in
                        expect(result).to(equal("0725272730706"))
                        done()
                    }
                }
            }
            
            it("should read infomation from EAN8barcode"){
                let testImage = UIImage(named: "EAN8barcode", in: Bundle(for: VisionUtilsSpecs.self), compatibleWith: nil)
                waitUntil(timeout: 2){ done in
                    VisionUtils.detectBarcode(image: testImage!) { (result) in
                        expect(result).to(equal("50184385"))
                        done()
                    }
                }
            }
        }
    }
}

