//
//  ViewController.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 06/01/2016.
//  Copyright (c) 2016 alexruperez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareAction(sender: AnyObject) {
        var items = [AnyObject]()
        
        if textField.text?.characters.count > 0 {
            items.append(textField.text!)
        }
        
        if linkField.text?.characters.count > 0 {
            if let linkURL = NSURL(string: linkField.text!) {
                items.append(linkURL)
            }
        }
        
        let shareViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        shareViewController.excludedActivityTypes = [UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop]
        if let popoverPresentationController = shareViewController.popoverPresentationController {
            popoverPresentationController.sourceView = shareButton
            popoverPresentationController.sourceRect = shareButton.frame
        }
        
        self.presentViewController(shareViewController, animated: true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

