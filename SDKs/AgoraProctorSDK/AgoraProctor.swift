//
//  AgoraProctor.swift
//  AgoraClassroomSDK_iOS
//
//  Created by Cavan on 2023/3/20.
//

import AgoraProctorUI
import AgoraEduCore

public typealias AgoraProctorMediaEncryptionConfig = AgoraEduCoreMediaEncryptionConfig
public typealias AgoraProctorMediaEncryptionMode = AgoraEduCoreMediaEncryptionMode
public typealias AgoraProctorVideoEncoderConfig = AgoraEduCoreVideoConfig
public typealias AgoraProctorLatencyLevel = AgoraEduCoreLatencyLevel
public typealias AgoraProctorMirrorMode = AgoraEduCoreMirrorMode
public typealias AgoraProctorExitReason = PtUISceneExitReason
public typealias AgoraProctorUserRole = AgoraEduCoreUserRole
public typealias AgoraProctorDelegate = PtUISceneDelegate
public typealias AgoraProctorRegion = AgoraEduCoreRegion

@objc public class AgoraProctorMediaOptions: NSObject {
    public var videoEncoderConfig: AgoraProctorVideoEncoderConfig
    public var encryptionConfig: AgoraProctorMediaEncryptionConfig?
    public var latencyLevel: AgoraProctorLatencyLevel
    
    public init(videoEncoderConfig: AgoraProctorVideoEncoderConfig,
                encryptionConfig: AgoraProctorMediaEncryptionConfig? = nil,
                latencyLevel: AgoraProctorLatencyLevel) {
        self.encryptionConfig = encryptionConfig
        self.videoEncoderConfig = videoEncoderConfig
        self.latencyLevel = latencyLevel
    }
    
    fileprivate func toCoreMediaOptions() -> AgoraEduCoreMediaOptions {
        let options = AgoraEduCoreMediaOptions(encryptionConfig: encryptionConfig,
                                               videoConfig: videoEncoderConfig,
                                               latencyLevel: latencyLevel)
        return options
    }
}

@objc public class AgoraProctorLaunchConfig: NSObject {
    public var userName: String
    public var userUuid: String
    public var userRole: AgoraProctorUserRole
    
    public var roomName: String
    public var roomUuid: String
    
    public var appId: String
    public var token: String
    public var region: AgoraProctorRegion
    
    public var mediaOptions: AgoraProctorMediaOptions
    public var userProperties: [String: Any]?
    
    @objc public init(userName: String,
                      userUuid: String,
                      userRole: AgoraProctorUserRole,
                      roomName: String,
                      roomUuid: String,
                      appId: String,
                      token: String,
                      region: AgoraProctorRegion,
                      mediaOptions: AgoraProctorMediaOptions,
                      userProperties: [String : Any]? = nil) {
        self.userName = userName
        self.userUuid = userUuid
        self.userRole = userRole
        self.roomName = roomName
        self.roomUuid = roomUuid
        self.appId = appId
        self.token = token
        self.region = region
        self.mediaOptions = mediaOptions
        self.userProperties = userProperties
    }
    
    fileprivate func isLegal() -> Error? {
        let message = ["message": "AgoraProctorLaunchConfig's parameter is illegal"]
        
        let error = NSError(domain: "",
                            code: -1,
                            userInfo: message)
        
        if userName.count < 1 {
            return error
        }
        
        if userUuid.count < 1 {
            return error
        }
        
        if roomName.count < 1 {
            return error
        }
        
        if roomUuid.count < 1 {
            return error
        }
        
        if appId.count < 1 {
            return error
        }
        
        if token.count < 1 {
            return error
        }
        
        return nil
    }
    
    fileprivate func toCoreConfig() -> AgoraEduCoreLaunchConfig {
        let config = AgoraEduCoreLaunchConfig(userName: userName,
                                              userUuid: userUuid,
                                              userProperties: userProperties,
                                              roomName: roomName,
                                              roomUuid: roomUuid,
                                              roomType: .proctor,
                                              startTime: nil,
                                              duration: nil,
                                              appId: appId,
                                              token: token,
                                              region: region,
                                              mediaOptions: mediaOptions.toCoreMediaOptions())
        return config
    }
}

@objc public class AgoraProctor: NSObject {
    public weak var delegate: PtUISceneDelegate?
    public var config: AgoraProctorLaunchConfig
    private(set) var core: AgoraEduCoreEngine
    private(set) var scene: PtUIScene?
    
    @objc public init(config: AgoraProctorLaunchConfig,
                      delegate: AgoraProctorDelegate? = nil) {
        self.config = config
        self.delegate = delegate
        
        let core = AgoraEduCoreEngine(config: config.toCoreConfig(),
                                      widgets: nil)
        
        self.core = core
    }
    
    @objc public func launch(success: (() -> Void)? = nil,
                             failure: ((Error) -> Void)? = nil) {
        if let error = config.isLegal() {
            failure?(error)
            return
        }
        
        core.launch { [weak self] pool in
            guard let `self` = self else {
                return
            }
            
            PtUIContext.create()
            
            let scene = PtUIScene(contextPool: pool,
                                  delegate: self.delegate)
            
            scene.modalPresentationStyle = .fullScreen
            
            self.scene = scene
            
            let topVC = UIViewController.agora_top_view_controller()
            
            topVC.present(scene,
                          animated: true) {
                success?()
            }
        } failure: { error in
            failure?(error)
        }
    }
    
    @objc public func version() -> String {
        guard let bundle = Bundle.agora_bundle("AgoraProctorSDK"),
              let dictionary = bundle.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else {
            return "1.0.0"
        }
        
        return version
    }
    
    @objc public func setParameters(_ parameters: [String: Any]) {
        core.setParameters(parameters)
    }
}
