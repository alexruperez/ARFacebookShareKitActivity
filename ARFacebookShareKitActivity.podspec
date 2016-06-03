Pod::Spec.new do |s|
  s.name             = 'ARFacebookShareKitActivity'
  s.version          = '1.0.1'
  s.summary          = 'Launch FBSDKShareKit from UIActivityViewController.'

  s.homepage         = 'https://github.com/alexruperez/ARFacebookShareKitActivity'
  s.screenshots      = [ 'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot1.jpg',
                         'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot2.jpg',
                         'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot3.jpg',
                         'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot4.jpg',
                         'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot5.jpg' ]
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexruperez' => 'contact@alexruperez.com' }
  s.source           = { :git => 'https://github.com/alexruperez/ARFacebookShareKitActivity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alexruperez'

  s.ios.deployment_target = '8.0'

  s.dependency 'FBSDKShareKit', '~> 4.12'
  s.dependency 'FBSDKCoreKit', '~> 4.12'
  s.dependency 'Bolts', '~> 1.7'
  
  s.subspec 'ActivityExtension' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/ActivityExtension/*.{h,m,swift}'
    ss.public_header_files = 'ARFacebookShareKitActivity/Classes/ActivityExtension/*.{h}'
    ss.resources = 'ARFacebookShareKitActivity/Assets/ActivityExtension/*.{bundle,xcassets,png,jpeg,jpg,storyboard,xib}'
  end
  
  s.subspec 'ShareLinkActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/ShareLinkActivity/*.{h,m,swift}'
    ss.public_header_files = 'ARFacebookShareKitActivity/Classes/ShareLinkActivity/*.{h}'
    ss.resources = 'ARFacebookShareKitActivity/Assets/ShareLinkActivity/*.{bundle,xcassets,png,jpeg,jpg,storyboard,xib}'
  end
  
  s.subspec 'AppInviteActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/AppInviteActivity/*.{h,m,swift}'
    ss.public_header_files = 'ARFacebookShareKitActivity/Classes/AppInviteActivity/*.{h}'
    ss.resources = 'ARFacebookShareKitActivity/Assets/AppInviteActivity/*.{bundle,xcassets,png,jpeg,jpg,storyboard,xib}'
  end
  
  s.subspec 'ShareMediaActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/ShareMediaActivity/*.{h,m,swift}'
    ss.public_header_files = 'ARFacebookShareKitActivity/Classes/ShareMediaActivity/*.{h}'
    ss.resources = 'ARFacebookShareKitActivity/Assets/ShareMediaActivity/*.{bundle,xcassets,png,jpeg,jpg,storyboard,xib}'
  end
end
