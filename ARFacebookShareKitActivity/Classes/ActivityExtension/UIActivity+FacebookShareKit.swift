//
//  UIActivity+FacebookShareKit.swift
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

public extension UIActivity {
    private struct AssociatedKeys {
        static var ActivityContent = "ar_ActivityContent"
    }
    
    var activityContent: FBSDKCopying? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActivityContent) as? FBSDKCopying
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.ActivityContent,
                    newValue as FBSDKCopying?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        let klass: AnyClass = NSClassFromString("UISoc"+"ialAct"+"ivity")!
        
        if self != klass {
            return
        }
        
        dispatch_once(&Static.token) {
            ARSwizzleInstanceMethod(klass, originalSelector: #selector(UIActivity.prepareWithActivityItems(_:)), swizzledSelector: #selector(UIActivity.ar_prepareWithActivityItems(_:)))
            
            ARSwizzleInstanceMethod(klass, originalSelector: #selector(UIActivity.canPerformWithActivityItems(_:)), swizzledSelector: #selector(UIActivity.ar_canPerformWithActivityItems(_:)))
            
            ARSwizzleInstanceMethod(klass, originalSelector: #selector(UIActivity.performActivity), swizzledSelector: #selector(UIActivity.ar_performActivity))
        }
    }
    
    class func ar_defaultFacebookActivityType() -> String? {
        struct Static {
            static var token: dispatch_once_t = 0
            static var activityType: String? = nil
        }
        dispatch_once(&Static.token) {
            Static.activityType = ["com", "apple", "UIKit", "activity", "PostToFacebook"].joinWithSeparator(".")
        }
        return Static.activityType
    }
    
    class func ar_canShowFacebookShareDialog() -> Bool {
        return FBSDKShareDialog().canShow()
    }
    
    class func ar_canShowFacebookAppInviteDialog() -> Bool {
        return FBSDKAppInviteDialog().canShow()
    }
    
    func ar_canUseFacebookActivityOverride() -> Bool {
        return activityType() == self.dynamicType.ar_defaultFacebookActivityType() && (self.dynamicType.ar_canShowFacebookShareDialog() || self.dynamicType.ar_canShowFacebookAppInviteDialog())
    }
    
    func ar_canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return ar_canUseFacebookActivityOverride() || ar_canPerformWithActivityItems(activityItems)
    }
    
    func ar_prepareWithActivityItems(activityItems: [AnyObject]) {
        if !ar_canUseFacebookActivityOverride() {
            ar_prepareWithActivityItems(activityItems)
            return
        }
        
        var sharedURL: NSURL? = nil
        var sharedText: String? = nil
        
        for itemSource in activityItems {
            var item: AnyObject? = nil
            if itemSource.conformsToProtocol(UIActivityItemSource) {
                if let activityType = activityType() {
                    item = (itemSource as? UIActivityItemSource)?.activityViewController(activityViewController() as! UIActivityViewController, itemForActivityType: activityType)
                }
            } else {
                item = itemSource
            }
            
            if let item = item as? NSURL {
                sharedURL = item
            } else if let item = item as? String {
                sharedText = item
            }
        }
        
        if sharedURL == nil && sharedText == nil {
            activityDidFinish(false)
            return
        }
        
        var isAppInvite = false
        
        if let sharedURL = sharedURL {
            if let branchUniversalLinkDomains = NSBundle.mainBundle().infoDictionary?["branch_universal_link_domains"] {
                if let oneDomain = branchUniversalLinkDomains as? String {
                    if sharedURL.host?.containsString(oneDomain) == true {
                        isAppInvite = true
                    }
                } else if let branchUniversalLinkDomains = branchUniversalLinkDomains as? [String] {
                    for oneDomain: String in branchUniversalLinkDomains {
                        if sharedURL.host?.containsString(oneDomain) == true {
                            isAppInvite = true
                        }
                    }
                }
            }
            
            let branchDomains = ["bnc.lt", "app.link", "test-app.link"]
            for oneDomain in branchDomains {
                if sharedURL.host?.containsString(oneDomain) == true {
                    isAppInvite = true
                }
            }
        }
        
        if isAppInvite {
            let appInviteContent = FBSDKAppInviteContent()
            appInviteContent.promotionText = sharedText
            appInviteContent.appLinkURL = sharedURL
            activityContent = appInviteContent
        } else {
            let linkContent = FBSDKShareLinkContent()
            linkContent.quote = sharedText
            linkContent.contentURL = sharedURL
            activityContent = linkContent
        }
    }
    
    func ar_performActivity() {
        if !ar_canUseFacebookActivityOverride() {
            ar_performActivity()
            return
        }
        
        if activityContent == nil {
            activityDidFinish(false)
            return
        }
        
        if let activityContent = activityContent as? FBSDKAppInviteContent {
            FBSDKAppInviteDialog.showFromViewController(activityViewController(), withContent: activityContent, delegate: self)
        } else if let activityContent = activityContent as? FBSDKSharingContent {
            FBSDKShareDialog.showFromViewController(activityViewController(), withContent: activityContent, delegate: self)
        }
    }
    
    static func ARSwizzleInstanceMethod(klass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(klass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(klass, swizzledSelector)
        
        let didAddMethod = class_addMethod(klass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(klass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
}
