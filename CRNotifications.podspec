Pod::Spec.new do |s|
  s.name             = 'CRNotifications'
  s.version          = '1.2.1'
  s.summary          = 'Custom in-app notifications.'

  s.description      = <<-DESC
CRNotifications are custom in-app notifications with 3 types of layouts. The notifications will animate in and out. They will hide when they are clicked on or with an automatic dismissal.
                       DESC

  s.homepage         = 'https://github.com/dkcas11/CRNotifications'
  s.screenshots      = 'https://camo.githubusercontent.com/8bb3b0d4e643c0adb2a048814c5319bf8a6aa413/687474703a2f2f693833312e70686f746f6275636b65742e636f6d2f616c62756d732f7a7a3233372f646b63617331312f737563636573732e6a7067', 'https://camo.githubusercontent.com/4b560687cb85b5a0dbc7945c4f15bf79b19db730/687474703a2f2f693833312e70686f746f6275636b65742e636f6d2f616c62756d732f7a7a3233372f646b63617331312f6572726f722e6a7067', 'https://camo.githubusercontent.com/5d60f3db58199f8fc5909e341c0233b38343e2aa/687474703a2f2f693833312e70686f746f6275636b65742e636f6d2f616c62756d732f7a7a3233372f646b63617331312f696e666f2e6a7067'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Casper Riboe & Herrick Wolber as contributor' => 'wolbereric@yahoo.fr' }
  s.source           = { :git => 'https://github.com/dkcas11/CRNotifications.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dkcas11'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  
  s.source_files = 'CRNotifications/Classes/**/*'
  s.resources    = "CRNotifications/Assets/*.xcassets"

  s.frameworks = 'UIKit'
end
