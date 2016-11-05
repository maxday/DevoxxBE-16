//
//  LiveHash.swift
//  hash2colors
//
//  Created by Maxime on 12/10/16.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

class LiveHash: UIViewController, UITextViewDelegate {

    var nestedTableViewController:HashTextTable!

    var color0: UIView!
    var color1: UIView!
    var color2: UIView!
    var color3: UIView!
    var color4: UIView!

    @IBOutlet var navBar: UINavigationBar!
    
    @IBAction func saveHashBtn(_ sender: AnyObject) {
        print("saveBtn clicked")
        Webservice().load(resource: HashColorItem.add(hashString : (nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text)!)) { result in
            if result == nil {
                OperationQueue.main.addOperation {
                    let alert = UIAlertController(title: "Oooops !", message: "An error occured, check your connection and try again", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                OperationQueue.main.addOperation {
                    let alert = UIAlertController(title: "Saved !", message: "Your hash has been successfully saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    Webservice().load(resource: HashColorItem.all) { result in
                        print("log all companies from bluemix backend")
                        print(result)
                        print("----")
                    }
                    print("toto")
                    
                }
            }
            
        }
    }
 /*
    @IBAction func saveHashBtn(_ sender: AnyObject) {
        print("saveBtn clicked")
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        hasChanged()
    }
    
    func hasChanged() {
        print("I've just been changed")
    
        guard let hashString = nestedTableViewController.hashTextView.text else {
            //log this error
            return
        }
  
        guard let cell = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) else {
            //log this error
            return
        }
        
       /* guard
            let cellColor0 = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? ColorCellTableView,
            let cellColor1 = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 1, section: 3)) as? ColorCellTableView,
            let cellColor2 = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 2, section: 3)) as? ColorCellTableView,
            let cellColor3 = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 3, section: 3)) as? ColorCellTableView,
            let cellColor4 = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 4, section: 3)) as? ColorCellTableView
        else {
            //log this error
            return
        }
        */
        
        let colorItem = HashColorItem(hash: hashString.sha1())
        nestedTableViewController.currentColor = colorItem
        let colorArray = colorItem.extractStringColors(hash: colorItem.hashString, result: [])
        
        

        
        
        
        cell.textLabel?.text = colorItem.hashString
    
        
        
        let width0 = Int((Float(colorItem.colors![0].size) * Float(self.view.bounds.width)) / Float(colorItem.totalSize!))
        let width1 = Int((Float(colorItem.colors![1].size) * Float(self.view.bounds.width)) / Float(colorItem.totalSize!))
        let width2 = Int((Float(colorItem.colors![2].size) * Float(self.view.bounds.width)) / Float(colorItem.totalSize!))
        let width3 = Int((Float(colorItem.colors![3].size) * Float(self.view.bounds.width)) / Float(colorItem.totalSize!))
        let width4 = Int((Float(colorItem.colors![4].size) * Float(self.view.bounds.width)) / Float(colorItem.totalSize!))

        let color0Color = UIColor(colorLiteralRed: Float(colorItem.colors![0].red) / 255,
                                         green: Float(colorItem.colors![0].green) / 255,
                                         blue: Float(colorItem.colors![0].blue) / 255,
                                         alpha: 1.0)

        let color1Color = UIColor(colorLiteralRed: Float(colorItem.colors![1].red) / 255,
                                         green: Float(colorItem.colors![1].green) / 255,
                                         blue: Float(colorItem.colors![1].blue) / 255,
                                         alpha: 1.0)
        
        let color2Color = UIColor(colorLiteralRed: Float(colorItem.colors![2].red) / 255,
                                         green: Float(colorItem.colors![2].green) / 255,
                                         blue: Float(colorItem.colors![2].blue) / 255,
                                         alpha: 1.0)
   
        let color3Color = UIColor(colorLiteralRed: Float(colorItem.colors![3].red) / 255,
                                         green: Float(colorItem.colors![3].green) / 255,
                                         blue: Float(colorItem.colors![3].blue) / 255,
                                         alpha: 1.0)
        
        let color4Color = UIColor(colorLiteralRed: Float(colorItem.colors![4].red) / 255,
                                         green: Float(colorItem.colors![4].green) / 255,
                                         blue: Float(colorItem.colors![4].blue) / 255,
                                         alpha: 1.0)
        

        color0.backgroundColor = color0Color
        color1.backgroundColor = color1Color
        color2.backgroundColor = color2Color
        color3.backgroundColor = color3Color
        color4.backgroundColor = color4Color
        
        color0.constraints[0].constant = CGFloat(width0)
        color1.constraints[0].constant = CGFloat(width1)
        color2.constraints[0].constant = CGFloat(width2)
        color3.constraints[0].constant = CGFloat(width3)
        color4.constraints[0].constant = CGFloat(width4)
        
        nestedTableViewController.tableView.reloadData()
        nestedTableViewController.hashTextView.becomeFirstResponder()
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nestedTableViewController" {
            guard let hashTextTable = segue.destination as? HashTextTable else {
                //todo log this error
                return
            }
            nestedTableViewController = hashTextTable
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        nestedTableViewController.hashTextView.delegate = self
        color0 = nestedTableViewController.color0
        color1 = nestedTableViewController.color1
        color2 = nestedTableViewController.color2
        color3 = nestedTableViewController.color3
        color4 = nestedTableViewController.color4
    }
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        print("----------------------------------------\(textView.text)")
        hasChanged()
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let sha1Input = nestedTableViewController.hashTextView else {
            //no yet initialized
            return
        }
        if sha1Input.textColor == UIColor.lightGray && sha1Input.isFirstResponder {
            sha1Input.text = nil
            sha1Input.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let sha1Input = nestedTableViewController.hashTextView else {
            //no yet initialized
            return
        }
        if sha1Input.text.isEmpty || sha1Input.text == "" {
            sha1Input.textColor = UIColor.lightGray
            sha1Input.text = "Input text here..."
        }
    }

    
}


