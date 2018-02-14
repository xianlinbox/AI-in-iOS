//
//  ViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 02/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit

let VISION = "Vision Demos"
let NLP = "NLP Demos"
let INDUSTRY = "Industry Examples"

class HomeViewController: UITableViewController {
    let menu:[String] = [VISION, NLP, INDUSTRY]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Datasource
extension HomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
}

//MARK: TableView Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menu[indexPath.row] {
        case VISION:
            self.performSegue(withIdentifier: "showVisionDemos", sender: self)
        case NLP:
            self.performSegue(withIdentifier: "showNLPDemo", sender: self)
        case INDUSTRY:
            break
        default:
            break
        }
    }
}

