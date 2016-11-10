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
    @IBOutlet var saveBtn: UIBarButtonItem!
    
    @IBAction func saveHashBtn(_ sender: AnyObject) {
        nestedTableViewController.hashTextView.resignFirstResponder()
        Webservice().load(resource: ColorScheme.add(baseUrl : ColorScheme.getBaseUrl(), hashString : (nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text)!)) { result in
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
                }
            }
            
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        //nestedTableViewController.hashTextView.resignFirstResponder()
        nestedTableViewController.hashTextView.becomeFirstResponder()
        hasChanged()
    }
    
    func hasChanged() {
    
        guard let hashString = nestedTableViewController.hashTextView.text else {
            //log this error
            return
        }
  
        guard let cell = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) else {
            //log this error
            return
        }
        
        guard let colorItem = try? ColorScheme(hash: hashString.sha1()) else {
            //log this error
            return
        }
        
        guard let cellColorScheme = nestedTableViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? ColorSchemeTableViewCell else {
            //log this error
            return
        }
        
        saveBtn.isEnabled = !hashString.isEmpty
        
        nestedTableViewController.currentColor = colorItem
        cell.textLabel?.text = colorItem.getHashString()
        let widthArray = colorItem.getWidth(maxSize: Float(self.view.bounds.width))
        let colorArray = colorItem.getColors().map({$0.toUIColor()})
        cellColorScheme.feed(colorArray: colorArray, widthArray: widthArray, label : colorItem.getHashString())

        nestedTableViewController.tableView.reloadSections(NSIndexSet(index: 3) as IndexSet, with: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.isEnabled = false
        nestedTableViewController.hashTextView.delegate = self
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
    
    func textViewDidChange(_ textView: UITextView) {
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


