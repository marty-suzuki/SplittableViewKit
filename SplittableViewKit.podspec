#
# Be sure to run `pod lib lint SplittableViewKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SplittableViewKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SplittableViewKit.'
  s.homepage         = 'https://github.com/marty-suzuki/SplittableViewKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marty-suzuki' => 's1180183@gmail.com' }
  s.source           = { :git => 'https://github.com/marty-suzuki/SplittableViewKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marty_suzuki'
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/**/*.{swift}'
  s.swift_version = '4.2'
end
