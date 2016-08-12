Pod::Spec.new do |s|
  s.name             = 'JLTreeMenu'
  s.version          = '0.1.0'
  s.summary          = 'IOS 8 JLTreeMenu.'
  s.description      = <<-DESC
IOS 7 Transitioning include pop flip ..
                       DESC
  s.homepage         = 'https://github.com/JulianSong/JLTreeMenu'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'junliang.song' => 'junliang.song@dianping.com' }
  s.source           = { :git => 'https://github.com/JulianSong/JLTreeMenu.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'JLTreeMenu/Classes/*'
  s.public_header_files = 'JLTreeMenu/Classes/*.h'
  s.frameworks = 'UIKit'
end
