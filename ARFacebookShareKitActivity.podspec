Pod::Spec.new do |s|
  s.name             = 'ARFacebookShareKitActivity'
  s.version          = '1.0.2'
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
  
  s.subspec 'SharingDelegateExtension' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/SharingDelegateExtension/*.swift'
  end

  s.subspec 'SharingExtension' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/SharingExtension/*.swift'
    ss.dependency 'ARFacebookShareKitActivity/SharingDelegateExtension'
  end
  
  s.subspec 'ShareLinkActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/ShareLinkActivity/*.swift'
    ss.resources = 'ARFacebookShareKitActivity/Assets/ShareLinkActivity/*.xcassets'
    ss.dependency 'ARFacebookShareKitActivity/SharingDelegateExtension'
  end
  
  s.subspec 'AppInviteActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/AppInviteActivity/*.swift'
    ss.resources = 'ARFacebookShareKitActivity/Assets/AppInviteActivity/*.xcassets'
    ss.dependency 'ARFacebookShareKitActivity/SharingDelegateExtension'
  end
  
  s.subspec 'ShareMediaActivity' do |ss|
    ss.source_files = 'ARFacebookShareKitActivity/Classes/ShareMediaActivity/*.swift'
    ss.resources = 'ARFacebookShareKitActivity/Assets/ShareMediaActivity/*.xcassets'
    ss.dependency 'ARFacebookShareKitActivity/SharingDelegateExtension'
  end
end
