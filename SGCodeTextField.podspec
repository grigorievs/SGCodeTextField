#
# Be sure to run `pod lib lint SGCodeTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SGCodeTextField'
  s.version          = '0.1.5'
  s.summary          = 'Simple pin code textfield for iOS and tvOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple pin code textfield. Customizable via Interface Builder or code.
                       DESC

  s.homepage         = 'https://github.com/grigorievs/SGCodeTextField'
  s.screenshots      = 'https://i.imgur.com/lu3lVkD.png', 'https://i.imgur.com/ZCy3YLV.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sergiu Grigoriev' => 'sergiugrig@gmail.com' }
  s.source           = { :git => 'https://github.com/grigorievs/SGCodeTextField.git', :tag => s.version}
  s.social_media_url = 'https://twitter.com/grigorievs'

  s.swift_versions = ['4.0', '4.2', '5.0', '5.1', '5.2]
  
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  
  s.source_files = 'SGCodeTextField/*.swift'
  s.frameworks = 'UIKit'
  
end
