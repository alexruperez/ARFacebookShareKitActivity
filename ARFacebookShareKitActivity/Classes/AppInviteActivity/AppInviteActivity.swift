//
//  AppInviteActivity.swift
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

@objc public class AppInviteActivity: UIActivity {
    
    public var title: String?
    public var image: UIImage?
    public static var category: UIActivityCategory?
    
    private lazy var appInviteDialog: FBSDKAppInviteDialog = {
        
        let appInviteDialog = FBSDKAppInviteDialog()
        appInviteDialog.delegate = self
        appInviteDialog.content = FBSDKAppInviteContent()
        
        return appInviteDialog
    }()
    
    public override class func activityCategory() -> UIActivityCategory {
        return category ?? .Share
    }
    
    public class func setActivityCategory(category: UIActivityCategory) {
        self.category = category
    }
    
    public convenience init(title: String?, image: UIImage?) {
        self.init()
        self.title = title
        self.image = image
    }
    
    public override func activityType() -> String? {
        return String(AppInviteActivity.self)
    }
    
    public override func activityTitle() -> String? {
        return title ?? NSLocalizedString("Facebook Invite", comment: "\(activityType()!) Title")
    }
    
    public override func activityImage() -> UIImage? {
        return image ?? UIImage(named: "\(activityType()!)\(AppInviteActivity.activityCategory().rawValue)", inBundle: NSBundle(forClass: AppInviteActivity.self), compatibleWithTraitCollection: nil)
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
