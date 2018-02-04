//
//  ViewController.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 02/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    let menu:[String] = ["Vision Demos","NLP Demos"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

