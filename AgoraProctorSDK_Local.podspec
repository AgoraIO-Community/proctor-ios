Pod::Spec.new do |spec|
  spec.name         = 'AgoraProctorSDK'
  spec.version      = '5.0.0'
  spec.summary      = 'Proctor scene SDK'

  spec.description  = "Proctor scene binary SDK "

  spec.homepage     = 'https://docs.agora.io/en/agora-class/landing-page?platform=iOS'
  spec.license      = { "type" => "Copyright", "text" => "Copyright 2020 agora.io. All rights reserved." }
  spec.author       = { "Agora Lab" => "developer@agora.io" }
  spec.source       = { :git => 'git@github.com:AgoraIO-Community/proctor-ios.git', :tag => spec.version.to_s }

  spec.ios.deployment_target = '10.0'
  spec.frameworks = 'AudioToolbox', 'Foundation', 'UIKit'
  spec.xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' } 
  
  spec.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => ['$(SRCROOT)/../Products/Libs/'] }
  spec.pod_target_xcconfig  = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64", "DEFINES_MODULE" => "YES" }
  spec.user_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64", "DEFINES_MODULE" => "YES" }
  spec.xcconfig             = { "BUILD_LIBRARY_FOR_DISTRIBUTION" => "YES" }
  spec.pod_target_xcconfig  = { "VALID_ARCHS" => "arm64 armv7 x86_64" }
  spec.user_target_xcconfig = { "VALID_ARCHS" => "arm64 armv7 x86_64" }

    # open source libs
  spec.dependency "AgoraProctorUI/Binary"
  spec.dependency "AgoraProctorUI/Resources"

    # open sources widgets
  spec.dependency "AgoraWidgets/Binary"
  spec.dependency "AgoraWidgets/Resources"
    
    # close source libs
  spec.dependency "AgoraEduCore/Binary"
  spec.dependency "AgoraWidget/Binary"
  
  spec.subspec "Source" do |ss|
    ss.source_files  = "SDKs/AgoraProctorSDK/**/*.{swift,h,m}"
    ss.public_header_files = [
      "SDKs/AgoraProctorSDK/Public/*.h"
  ]
  end
  
  spec.subspec "Binary" do |ss|
    ss.vendored_frameworks = [
      "Products/Libs/AgoraProctorSDK/*.framework"
    ]
  end

  spec.default_subspec = "Source"


end
