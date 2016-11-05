//
//  ViewController.swift
//  hash2colors
//
//  Created by Maxime on 09/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    var r: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Browse Hash"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Webservice().load(resource: HashColorItem.all) { result in
            self.r = result?.reversed()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        if let colorCell = cell as? ColorSchemeTableViewCell {
            let hashString = r?[indexPath.row]
            let hashColorItem = HashColorItem(hash: hashString!)
            let colorArray = hashColorItem.extractColors(hash: hashColorItem.hashString, result: [])
            let widthArray = hashColorItem.getWidth(maxSize: Float(self.view.bounds.size.width))
            colorCell.label?.text = r?[indexPath.row]
            colorCell.color0.backgroundColor = colorArray[0].toUIColor()
            colorCell.color1.backgroundColor = colorArray[1].toUIColor()
            colorCell.color2.backgroundColor = colorArray[2].toUIColor()
            colorCell.color3.backgroundColor = colorArray[3].toUIColor()
            colorCell.color4.backgroundColor = colorArray[4].toUIColor()
            colorCell.color0.constraints[0].constant = CGFloat(widthArray[0])
            colorCell.color1.constraints[0].constant = CGFloat(widthArray[1])
            colorCell.color2.constraints[0].constant = CGFloat(widthArray[2])
            colorCell.color3.constraints[0].constant = CGFloat(widthArray[3])
            colorCell.color4.constraints[0].constant = CGFloat(widthArray[4])
        }
        return cell
    }


}

