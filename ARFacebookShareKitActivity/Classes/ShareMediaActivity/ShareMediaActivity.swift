//
//  ShareMediaActivity
//  ARFacebookShareKitActivity
//
//  Created by alexruperez on 2/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import FBSDKShareKit

@objc public class ShareMediaActivity: UIActivity {
    
    public var title: String?
    public var image: UIImage?
    public var mode: FBSDKShareDialogMode = .Automatic
    public static var category: UIActivityCategory?
    
    private lazy var shareDialog: FBSDKShareDialog = {
        
        let shareDialog = FBSDKShareDialog()
        shareDialog.delegate = self
        let shareContent = FBSDKShareMediaContent()
        shareContent.media = [AnyObject]()
        shareDialog.shareContent = shareContent
        shareDialog.mode = self.mode
        
        return shareDialog
    }()
    
    public override class func activityCategory() -> UIActivityCategory {
        return category ?? .Share
    }
    
    public class func setActivityCategory(category: UIActivityCategory) {
        self.category = category
    }
    
    public convenience init(title: String?, image: UIImage?, mode: FBSDKShareDialogMode) {
        self.init()
        self.title = title
        self.image = image
        self.mode = mode
    }
    
    public override func activityType() -> String? {
        return String(ShareMediaActivity.self)
    }
    
    public override func activityTitle() -> String? {
        return title ?? NSLocalizedString("Facebook Upload", comment: "\(activityType()!) Title")
    }
    
    public override func activityImage() -> UIImage? {
        return image ?? UIImage(named: "\(activityType()!)\(ShareMediaActivity.activityCategory().rawValue)", inBundle: NSBundle(forClass: ShareMediaActivity.self), compatibleWithTraitCollection: nil)
    }
    
    public override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if let contentURL = item as? NSURL {
                shareDialog.shareContent.contentURL = contentURL
            }
            if let image = item as? UIImage {
                if let shareContent = shareDialog.shareContent as? FBSDKShareMediaContent {
                    let photo = FBSDKSharePhoto(image: image, userGenerated: true)
                    shareContent.media.append(photo)
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
