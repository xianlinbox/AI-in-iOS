//
//  VisionDemosViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

let FACE_RECOG = "Face Recoginisation"
let FACE_LANDMARKS = "Face Landmarks"
let BARCODE_READ = "Barcode Reading"
let SPEC_RECOG = "Classification"
let REALTIME_FACE_ADDON = "Realtime Face Add-on"

class VisionDemosViewController: UITableViewController {
    let demos: [String] = [FACE_RECOG, FACE_LANDMARKS, BARCODE_READ, SPEC_RECOG, REALTIME_FACE_ADDON]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: TableView Datasource
extension VisionDemosViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.demos.count
    }
}

// MARK: TableView Delegate
extension VisionDemosViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoItem", for: indexPath)
        cell.textLabel?.text = demos[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch demos[indexPath.row] {
        case FACE_RECOG:
            self.performSegue(withIdentifier: "showFaceRecogDemo", sender: self)
        case FACE_LANDMARKS:
            self.performSegue(withIdentifier: "showFaceLandmarks", sender: self)
        case BARCODE_READ:
            self.performSegue(withIdentifier: "showBarcodeDemo", sender: self)
        case SPEC_RECOG:
            self.performSegue(withIdentifier: "showClassification", sender: self)
        case REALTIME_FACE_ADDON:
            self.performSegue(withIdentifier: "showDynamicTrack", sender: self)
        default:
            print("Test**********")
            break
        }
    }
}
