#
# Be sure to run `pod lib lint GodEye.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GodEye'
  s.version          = '1.3.0'
  s.summary          = 'Automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code based on Swift. Just like God opened his eyes.'
  s.swift_version    = '4.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Automaticly display Log,Crash,Network,ANR,Leak,CPU,RAM,FPS,NetFlow,Folder and etc with one line of code based on Swift. Just like God opened his eyes..
支持swift最低版本4.0，支持iOS最低版本10.0
                       DESC

  s.homepage         = 'https://github.com/Bogon/GodEye'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bogon' => 'zhangqixcu@gmail.com' }
  s.source           = { :git => 'https://github.com/Bogon/GodEye.git', :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/zixun_'

  s.ios.deployment_target = '10.0'

  s.source_files = 'GodEye/Classes/**/*'
  
  s.resource_bundles = {
    'GodEye' => ['GodEye/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

    s.dependency 'AppBaseKit'
    s.dependency 'Log4G'
    s.dependency 'AppSwizzle'
    s.dependency 'AssistiveButton'

    s.dependency 'ASLEye'
    s.dependency 'CrashEye'
    s.dependency 'ANREye'
    s.dependency 'SystemEye'
    s.dependency 'NetworkEye.swift'
    s.dependency 'LeakEye'

    s.dependency 'FileBrowser', '~> 0.2.0'
    s.dependency 'SwViewCapture'
    s.dependency 'SQLite.swift', '~> 0.11.1'
    s.dependency 'MJRefresh', '~> 3.1.12'
    
    s.dependency 'CCProgressHUDKit'
end
