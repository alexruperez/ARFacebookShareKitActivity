Pod::Spec.new do |s|
  s.name             = 'ARFacebookShareKitActivity'
  s.version          = '0.1.4'
  s.summary          = 'Launch FBSDKShareKit from UIActivityViewController instead of the default share sheet.'

  s.homepage         = 'https://github.com/alexruperez/ARFacebookShareKitActivity'
  s.screenshots      = [ 'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot1.jpg',
                        'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot2.jpg',
                        'https://raw.githubusercontent.com/alexruperez/ARFacebookShareKitActivity/master/screenshot3.jpg' ]
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexruperez' => 'contact@alexruperez.com' }
  s.source           = { :git => 'https://github.com/alexruperez/ARFacebookShareKitActivity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alexruperez'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ARFacebookShareKitActivity/Classes/**/*'

  s.dependency 'FBSDKShareKit', '~> 4.12'
  s.dependency 'FBSDKCoreKit', '~> 4.12'
  s.dependency 'Bolts', '~> 1.7'
end
