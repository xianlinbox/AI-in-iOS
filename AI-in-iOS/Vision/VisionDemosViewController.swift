//
//  VisionDemosViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

let FACE_RECOG = "Face Recoginisation"
let SPEC_RECOG = "Spec Recoginisation"
let TEXT_RECOG = "Spec Recoginisation"
let REALTIME_FACE_RECOG = "Realtime Face Recoginisation"
let REALTIME_FACE_ADDON = "Realtime Face Add-on"

class VisionDemosViewController: UITableViewController {
    let demos:[String] = [FACE_RECOG, SPEC_RECOG, TEXT_RECOG, REALTIME_FACE_RECOG, REALTIME_FACE_ADDON]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Datasource
extension VisionDemosViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.demos.count
    }
}

//MARK: TableView Delegate
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
        default:
            print("Test**********")
            break;
        }
    }
}

