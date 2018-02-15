//
//  NLPUtilsSpecs.swift
//  AI-in-iOSTests
//
//  Created by Xianning Liu  on 15/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import Quick
import Nimble

class NLPUtilsSpecs: QuickSpec {
    override func spec() {
        describe("NLPUtils") {
            it("split sentence to tags", closure: {
                let sentence = "It is you!"
                NLPUtils.tagSentence(sentence:sentence){ (result) in
                    expect(result.count).to(equal(4))
                }
            })
            
            it("split sentence to tags with compact words", closure: {
                let sentence = "It's you!"
                NLPUtils.tagSentence(sentence:sentence){ (result) in
                    expect(result.count).to(equal(4))
                }
            })
        }
    }
}
