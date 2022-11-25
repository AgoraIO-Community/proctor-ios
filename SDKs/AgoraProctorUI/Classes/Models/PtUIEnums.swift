//
//  PtUIEnums.swift
//  AgoraProctorUI
//
//  Created by LYY on 2022/9/5.
//

import AgoraEduCore

@objc public enum PtUISceneExitReason: Int {
    case normal, kickOut
}

enum FcrProctorUIExamState {
    case before(countdown: Int,
                startTime: Int64)
    case during(timeInfo: FcrProctorExamTimeInfo)
    case after(timeInfo: FcrProctorExamTimeInfo)
}

enum FcrProctorUIDeviceType: String {
    case main = "main"
    case sub = "sub"
}
