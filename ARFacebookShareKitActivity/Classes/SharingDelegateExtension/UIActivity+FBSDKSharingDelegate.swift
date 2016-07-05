//
//  UIActivity+FBSDKSharingDelegate.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

extension UIActivity : FBSDKAppInviteDialogDelegate, FBSDKSharingDelegate {
    public func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        activityDidFinish(true)
    }
    
    public func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        let appInviteContent = appInviteDialog.content
        let linkContent = FBSDKShareLinkContent()
        linkContent.quote = appInviteContent.promotionText
        linkContent.contentURL = appInviteContent.appLinkURL
        FBSDKShareDialog.showFromViewController(appInviteDialog.fromViewController, withContent: linkContent, delegate: self)
    }
    
    public func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        activityDidFinish(true)
    }
    
    public func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        activityDidFinish(false)
    }
    
    public func sharerDidCancel(sharer: FBSDKSharing!) {
        activityDidFinish(false)
    }
}
