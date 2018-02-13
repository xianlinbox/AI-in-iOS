//
//  CoreMLUtilsTests.swift
//  AI-in-iOSTests
//
//  Created by Xianning Liu  on 13/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Quick
import Nimble

class CoreMLUtilsSpecs: QuickSpec {
    override func spec() {
        describe("CoreMLUtils") {
            it("should recognise it as a building over 50% possibility") {
                let treeImage = UIImage(named: "building", in: Bundle(for:CoreMLUtilsSpecs.self), compatibleWith: nil)
                waitUntil(timeout: 1){ done in
                    CoreMLUtils.detectImage(image: treeImage!, completion: { result in
                        expect(result.first!.confidence) > 0.5
                        done()
                    })
                }
            }
            
            it("should recognise it as a tree over 30% possibility") {
                let treeImage = UIImage(named: "tree", in: Bundle(for:CoreMLUtilsSpecs.self), compatibleWith: nil)
                waitUntil(timeout: 1){ done in
                    CoreMLUtils.detectImage(image: treeImage!, completion: { result in
                        expect(result.first!.confidence) > 0.3
                        done()
                    })
                }
            }
        }
    }
}

