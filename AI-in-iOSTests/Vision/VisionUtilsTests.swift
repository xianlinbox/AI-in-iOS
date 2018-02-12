//
//  VisionUtilsTests.swift
//  AI-in-iOSTests
//
//  Created by Xianning Liu  on 12/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import XCTest

class VisionUtilsTests: XCTestCase {
    
    func testshould_read_info_from_QRCode() {
        let testImage = UIImage(named: "QRCode")
        VisionUtils.detectBarcode(image: testImage!) { (result) in
            XCTAssertEqual(result, "http://en.m.wikipedia.org")
        }
    }
}
