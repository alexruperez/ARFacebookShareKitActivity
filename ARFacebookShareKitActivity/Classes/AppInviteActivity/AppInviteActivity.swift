//
//  AppInviteActivity.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

class AppInviteActivity: UIActivity {
    
    var title: String?
    var image: UIImage?
    
    private lazy var appInviteDialog: FBSDKAppInviteDialog = {
        
        let appInviteDialog = FBSDKAppInviteDialog()
        appInviteDialog.delegate = self
        appInviteDialog.content = FBSDKAppInviteContent()
        
        return appInviteDialog
    }()
    
    public override class func activityCategory() -> UIActivityCategory {
        return .Share
    }
    
    public override func activityType() -> String? {
        return String(self.dynamicType)
    }
    
    public override func activityTitle() -> String? {
        return title ?? NSLocalizedString("Invite through Facebook", comment: "\(activityType()!) Title")
    }
    
    public override func activityImage() -> UIImage? {
        return image ?? UIImage(named: activityType()!, inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
    }
    
    public override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if let appLinkURL = item as? NSURL {
                appInviteDialog.content.appLinkURL = appLinkURL
            }
            if let promotionText = item as? String {
                appInviteDialog.content.promotionText = promotionText
            }
        }
        
        do {
            try appInviteDialog.validate()
            return appInviteDialog.canShow()
        } catch {
            return false
        }
    }
    
    public override func performActivity() {
        appInviteDialog.show()
    }
    
}
