#
# Be sure to run `pod lib lint LinkITrack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LinkITrack'
  s.version          = '1.0.1'
  s.summary          = 'A small utility to include tracking in your own app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Add client-tracking into your own app from LinkIT'
  
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES'
    
  }
  s.static_framework = true
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.swift_versions = '4.0'

  s.homepage         = 'https://github.com/Towbe/LinkITrack'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinkIT' => 'admin@towbe.com' }
  s.source           = { :git => 'https://github.com/Towbe/LinkITrack-IOs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = "10.0"

  s.source_files = 'LinkITrack/Classes/**/*'
  
  s.resources = ['LinkITrack/Resources/**/*', 'LinkITrack/Assets/**/*']
  
  # s.resource_bundles = {
  #   'LinkITrack' => ['LinkITrack/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'GoogleMaps'
  
  s.frameworks = "Foundation", "UIKit"
end
