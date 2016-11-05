//
//  ViewController.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    var r: [HashColorItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        Webservice().load(resource: HashColorItem.all) { result in
            print("log all companies from bluemix backend")
            print(result)
            self.r = result
            self.tableView.reloadData()
            print("----")
        }
        print("toto")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (r?.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        cell.textLabel?.font = UIFont(name: "Arial", size: 10.0)
        cell.textLabel?.text = r?[indexPath.row].hashString
        return cell
    }


}

