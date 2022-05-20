#
# Be sure to run `pod lib lint JZComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JZComponents'
  s.version          = '0.1.0'
  s.summary          = 'iOS开发常用集合.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  整理iOS常用的组件库，不断更新.
                       DESC

  s.homepage         = 'https://github.com/Jentle'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jentle-Zhi' => 'juntaozhi@163.com' }
  s.source           = { :git => 'https://github.com/Jentlezhi/JZComponents', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  #s.source_files = 'JZComponents/Classes/**/*'
  #公用.h文件
  s.subspec 'Public' do |ss|
     ss.source_files = 'JZComponents/Public/*.{h,m}'
  end
  #Foundation扩展
  s.subspec 'FoundationExtension' do |ss|
     ss.source_files = 'JZComponents/Components/FoundationExtension/*.{h,m}'
     ss.dependency 'YYModel'
  end
  #UIkit扩展
  s.subspec 'UIKitExtension' do |ss|
     ss.source_files = 'JZComponents/Components/UIKitExtension/*.{h,m}'
  end
  #常用工具类
  s.subspec 'Utility' do |ss|
     ss.source_files = 'JZComponents/Utility/*.{h,m}'
  end
  
  # s.resource_bundles = {
  #   'JZComponents' => ['JZComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
