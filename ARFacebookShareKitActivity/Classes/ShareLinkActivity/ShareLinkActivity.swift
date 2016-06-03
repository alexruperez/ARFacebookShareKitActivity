//
//  ShareLinkActivity.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

@objc public class ShareLinkActivity: UIActivity {
    
    public var title: String?
    public var image: UIImage?
    public var mode: FBSDKShareDialogMode?
    public static var category: UIActivityCategory?
    
    private lazy var shareDialog: FBSDKShareDialog = {
        
        let shareDialog = FBSDKShareDialog()
        shareDialog.delegate = self
        shareDialog.shareContent = FBSDKShareLinkContent()
        shareDialog.mode = self.mode ?? .Automatic
        
        return shareDialog
    }()
    
    public override class func activityCategory() -> UIActivityCategory {
        return category ?? .Share
    }
    
    public convenience init(title: String?, image: UIImage?, mode: FBSDKShareDialogMode?) {
        self.init()
        self.title = title
        self.image = image
        self.mode = mode
    }
    
    public override func activityType() -> String? {
        return String(ShareLinkActivity.self)
    }
    
    public override func activityTitle() -> String? {
        return title ?? NSLocalizedString("Facebook Share", comment: "\(activityType()!) Title")
    }
    
    public override func activityImage() -> UIImage? {
        return image ?? UIImage(named: "\(activityType()!)\(ShareLinkActivity.activityCategory().rawValue)", inBundle: NSBundle(forClass: ShareLinkActivity.self), compatibleWithTraitCollection: nil)
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
