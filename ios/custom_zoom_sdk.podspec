    #
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'custom_zoom_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin for zoom customization.'
  s.description      = <<-DESC
A new Flutter plugin for zoom customization.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Phoeniixx' => 'sagar@phoeniixx.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.swift_version = '5.0'

  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework MobileRTC' }
  s.preserve_paths = 'MobileRTC.framework', 'MobileRTCResources.bundle'
  s.vendored_frameworks = 'MobileRTC.framework'
  s.resource = 'MobileRTCResources.bundle'

end
