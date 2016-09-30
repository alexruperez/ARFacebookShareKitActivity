//
//  ViewController.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 06/01/2016.
//  Copyright (c) 2016 alexruperez. All rights reserved.
//

import UIKit
import ARFacebookShareKitActivity

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareAction(sender: AnyObject) {
        var items = [AnyObject]()
        
        if let text = textField.text, text.characters.count > 0 {
            items.append(text as AnyObject)
        }

        if let text = linkField.text, text.characters.count > 0 {
            if let linkURL = NSURL(string: linkField.text!) {
                items.append(linkURL)
            }
        }
        
        let shareViewController = UIActivityViewController(activityItems: items, applicationActivities: [AppInviteActivity(), ShareLinkActivity()])
        shareViewController.excludedActivityTypes = [.postToTwitter, .postToWeibo, .message, .mail, .print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList, .postToFlickr, .postToVimeo, .postToTencentWeibo, .airDrop]
        if let popoverPresentationController = shareViewController.popoverPresentationController {
            popoverPresentationController.sourceView = shareButton
            popoverPresentationController.sourceRect = CGRect(x: shareButton.frame.width/2, y: 0, width: 0, height: 0)
        }

        self.present(shareViewController, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

