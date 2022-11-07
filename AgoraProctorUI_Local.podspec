Pod::Spec.new do |spec|
    spec.name         = "AgoraProctorUI"
    spec.version      = "1.0.0"
    spec.summary      = "Agora Proctor UI"
    spec.description  = "Agora Proctor UI SDK"
    spec.homepage     = "https://docs.agora.io/en/agora-class/landing-page?platform=iOS"
    spec.license      = { "type" => "Copyright", "text" => "Copyright 2020 agora.io. All rights reserved." }
    spec.author       = { "Agora Lab" => "developer@agora.io" }
    spec.module_name  = "AgoraProctorUI"
  
    spec.ios.deployment_target = "10.0"
    spec.swift_versions        = ["5.0", "5.1", "5.2", "5.3", "5.4"]
  
    spec.source              = { :git => "git@github.com:AgoraIO-Community/CloudClass-iOS.git", :tag => "AgoraProctorUI_v" + "#{spec.version.to_s}" }
    spec.public_header_files = "SDKs/AgoraProctorUI/Classes/**/*.h"
    spec.source_files        = "SDKs/AgoraProctorUI/Classes/**/*.{h,m,swift}"
    
    spec.dependency "SwifterSwift"
    spec.dependency "SDWebImage"
    spec.dependency "Masonry"
    
    spec.pod_target_xcconfig  = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64", "DEFINES_MODULE" => "YES" }
    spec.user_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64", "DEFINES_MODULE" => "YES" }
    spec.pod_target_xcconfig  = { "VALID_ARCHS" => "arm64 armv7 x86_64" } 
    spec.user_target_xcconfig = { "VALID_ARCHS" => "arm64 armv7 x86_64" }
    spec.xcconfig             = { "BUILD_LIBRARY_FOR_DISTRIBUTION" => "YES" }

    spec.subspec "Source" do |ss|
      ss.public_header_files = "SDKs/AgoraProctorUI/Classes/**/*.h"
      ss.source_files        = "SDKs/AgoraProctorUI/Classes/**/*.{h,m,swift}"
      ss.resource_bundles = {
        "AgoraProctorUI" => ["SDKs/AgoraProctorUI/Assets/**/*.{xcassets,strings,gif,mp3}"]
      }

      ss.dependency "AgoraUIBaseViews/Source"
      ss.dependency "AgoraEduCore/Source"
      ss.dependency "AgoraWidget/Source"
    end

    spec.subspec "Build" do |ss|
      ss.public_header_files = "SDKs/AgoraProctorUI/Classes/**/*.h"
      ss.source_files        = "SDKs/AgoraProctorUI/Classes/**/*.{h,m,swift}"
      ss.resource_bundles = {
        "AgoraProctorUI" => ["SDKs/AgoraProctorUI/Assets/**/*.{xcassets,strings,gif,mp3}"]
      }

      ss.dependency "AgoraUIBaseViews/Binary"
      ss.dependency "AgoraEduCore/Binary"
      ss.dependency "AgoraWidget/Binary"
    end
  
    spec.subspec "Binary" do |ss|
      ss.vendored_frameworks = [
        "Products/Libs/AgoraProctorUI/*.framework"
      ]
      
      ss.dependency "AgoraUIBaseViews/Binary"
      ss.dependency "AgoraEduCore/Binary"
      ss.dependency "AgoraWidget/Binary"
    end

    spec.default_subspec = "Source"
  end
  
