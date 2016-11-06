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
        
        guard let colorItem = try? HashColorItem(hash: hashString.sha1()) else {
            //log this error
            return
        }
        
        nestedTableViewController.currentColor = colorItem
        cell.textLabel?.text = colorItem.hashString
        
        let widthArray = colorItem.getWidth(maxSize: Float(self.view.bounds.width))
        let colorArray = colorItem.extractColors()
        
        
        color0.backgroundColor = colorArray[0].toUIColor()
        color1.backgroundColor = colorArray[1].toUIColor()
        color2.backgroundColor = colorArray[2].toUIColor()
        color3.backgroundColor = colorArray[3].toUIColor()
        color4.backgroundColor = colorArray[4].toUIColor()
        
        color0.constraints[0].constant = CGFloat(widthArray[0])
        color1.constraints[0].constant = CGFloat(widthArray[1])
        color2.constraints[0].constant = CGFloat(widthArray[2])
        color3.constraints[0].constant = CGFloat(widthArray[3])
        color4.constraints[0].constant = CGFloat(widthArray[4])
        
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


