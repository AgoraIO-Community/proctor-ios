Pod::Spec.new do |spec|
  spec.name         = 'AgoraProctorSDK'
  spec.version      = '1.0.0'
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
  
  spec.subspec "Source" do |ss|
    ss.source_files  = "SDKs/AgoraProctorSDK/**/*.{swift,h,m}"
    ss.public_header_files = [
      "SDKs/AgoraProctorSDK/Public/*.h"
  ]

    # open source libs
    ss.dependency "AgoraProctorUI/Source"
      
    # close source libs
    ss.dependency "AgoraEduCore/Source"
    ss.dependency "AgoraWidget/Source"
  end

  spec.subspec "Build" do |ss|
    ss.source_files  = "SDKs/AgoraProctorSDK/**/*.{swift,h,m}"
    ss.public_header_files = [
      "SDKs/AgoraProctorSDK/Public/*.h"
  ]

    # open source libs
    ss.dependency "AgoraProctorUI/Binary"
      
    # close source libs
    ss.dependency "AgoraEduCore/Binary"
    ss.dependency "AgoraWidget/Binary"
  end
  
  spec.subspec "Binary" do |ss|
    ss.vendored_frameworks = [
      "Products/Libs/AgoraProctorSDK/*.framework"
    ]

    # open source libs
    ss.dependency "AgoraProctorUI/Binary"
      
    # close source libs
    ss.dependency "AgoraEduCore/Binary"
    ss.dependency "AgoraWidget/Binary"
  end

  spec.default_subspec = "Source"
end
