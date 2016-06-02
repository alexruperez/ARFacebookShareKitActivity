//
//  ShareLinkActivity.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

class ShareLinkActivity: UIActivity {
    
    var title: String?
    var image: UIImage?
    var mode: FBSDKShareDialogMode?
    
    private lazy var shareDialog: FBSDKShareDialog = {
        
        let shareDialog = FBSDKShareDialog()
        shareDialog.delegate = self
        shareDialog.shareContent = FBSDKShareLinkContent()
        shareDialog.mode = self.mode ?? .Automatic
        
        return shareDialog
    }()
    
    public override class func activityCategory() -> UIActivityCategory {
        return .Share
    }
    
    public override func activityType() -> String? {
        return String(self.dynamicType)
    }
    
    public override func activityTitle() -> String? {
        return title ?? NSLocalizedString("Share through Facebook", comment: "\(activityType()!) Title")
    }
    
    public override func activityImage() -> UIImage? {
        return image ?? UIImage(named: activityType()!, inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
    }
    
    public override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if let contentURL = item as? NSURL {
                shareDialog.shareContent.contentURL = contentURL
            }
            if let quote = item as? String {
                if let shareContent = shareDialog.shareContent as? FBSDKShareLinkContent {
                    shareContent.quote = quote
                }
            }
        }
        
        do {
            try shareDialog.validate()
            return shareDialog.canShow()
        } catch {
            return false
        }
    }
    
    public override func performActivity() {
        shareDialog.show()
    }
    
}
