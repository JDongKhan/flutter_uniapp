#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_uniapp.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_uniapp'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*','Core/Headers/**/*.h'
  s.vendored_frameworks = 'Core/Libs/*.framework'
  s.vendored_libraries = 'Core/Libs/*.a'
  s.public_header_files = 'Classes/**/*.h','Core/Headers/**/*.h'
#  s.resource = 'Core/Resources/*.bundle'
#  s.resources = 'Core/Resources/*.js','Core/Resources/*.ttf'
#  s.static_framework = true
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'OTHER_LDFLAGS' => '-ObjC'
  }
  s.swift_version = '5.0'
  s.frameworks = [
      'JavaScriptCore','CoreMedia','MediaPlayer','AVFoundation','AVKit','GLKit','OpenGLES','CoreText','QuartzCore','CoreGraphics','QuickLook','CoreTelephony','AssetsLibrary','CoreLocation','AddressBook'
      ]
  s.libraries = ['iconv','c++']
  
end
