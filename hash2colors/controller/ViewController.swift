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
        Webservice().load(resource: ColorScheme.all) { result in
            self.r = result?.reversed()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (r?.count) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        if let cellColorScheme = cell as? ColorSchemeTableViewCell {
            let hashString = r?[indexPath.row]

            guard let hashColorItem = try? ColorScheme(hash: hashString) else {
                //log this error
                return cellColorScheme
            }

            let widthArray = hashColorItem.getWidth(maxSize: Float(self.view.bounds.width))
            let colorArray = hashColorItem.getColors().map({$0.toUIColor()})
            cellColorScheme.feed(colorArray: colorArray, widthArray: widthArray, label : hashColorItem.getHashString())
        }
        return cell
    }


}

