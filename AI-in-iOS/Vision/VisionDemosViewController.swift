//
//  VisionDemosViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 04/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import UIKit

class VisionDemosViewController: UITableViewController {
  let demos: [String] = [VisionConstants.faceRecog,
                         VisionConstants.faceLandmarks,
                         VisionConstants.barcodeRead,
                         VisionConstants.specRecog,
                         VisionConstants.realtimeFaceAddon]
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
          case VisionConstants.faceRecog:
              self.performSegue(withIdentifier: "showFaceRecogDemo", sender: self)
          case VisionConstants.faceLandmarks:
              self.performSegue(withIdentifier: "showFaceLandmarks", sender: self)
          case VisionConstants.barcodeRead:
              self.performSegue(withIdentifier: "showBarcodeDemo", sender: self)
          case VisionConstants.specRecog:
              self.performSegue(withIdentifier: "showClassification", sender: self)
          case VisionConstants.realtimeFaceAddon:
              self.performSegue(withIdentifier: "showDynamicTrack", sender: self)
          default:
              print("Test**********")
          }
      }
}
