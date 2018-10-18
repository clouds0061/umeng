#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'umeng'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
  
  
  s.xcconfig = { 'OTHER_LDFLAGS' => '-lz' }
#    s.vendored_frameworks = 'Classes/UMCommon.framework','Classes/UMCSecurityPlugins.framework','UTDID.framework','Classes/UMAnalytics.framework','Classes/UMCommonLog.framework'
    s.vendored_frameworks ='Classes/UMCommon.framework','Classes/UMAnalytics.framework','Classes/UMCommonLog.framework'
#  s.vendored_frameworks =['Classes/UMCommon.framework','Classes/UMAnalytics.framework']

end

