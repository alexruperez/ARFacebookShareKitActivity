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
        activityDidFinish(false)
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
