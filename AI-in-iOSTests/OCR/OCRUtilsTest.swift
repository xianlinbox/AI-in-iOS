//
//  OCRUtilsTest.swift
//  AI-in-iOSTests
//
//  Created by Xianning Liu  on 01/03/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Quick
import Nimble

class OCRUtilsTest: QuickSpec {

    override func spec() {
        describe("OCRUtils") {
            it("should recognise chinese text", closure: {
                let image = UIImage(named: "chinese")
                waitUntil(timeout: 2, action: { (done) in
                    OCRUtils.recogText(image: image!, { (result) in
                        expect(result).to(equal("红烧翅膀，我喜欢吃"))
                        done()
                    })
                })
            })
        }
    }
    
}
