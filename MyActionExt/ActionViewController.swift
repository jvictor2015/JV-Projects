//
//  ActionViewController.swift
//  MyActionExt
//
//  Created by John A Victor on 8/4/20.
//  Copyright © 2020 John A Victor. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    
    var convertedString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier:
            kUTTypeText as String,
                            options: nil,
                 completionHandler: { (result, error) in

                 self.convertedString = result as? String

                 if self.convertedString != nil {
                     self.convertedString = self.convertedString!.uppercased()

                     DispatchQueue.main.async {
                         self.myTextView.text = self.convertedString!
                     }
                 }
            })
        }
}
    
    @IBAction func done() {
        let returnProvider = NSItemProvider(item: convertedString as NSSecureCoding?, typeIdentifier: kUTTypeText as String)
        
        let returnItem = NSExtensionItem()
        
        returnItem.attachments = [returnProvider]
        self.extensionContext!.completeRequest(returningItems: [returnItem], completionHandler: nil)
    }
}
