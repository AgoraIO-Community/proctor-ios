//
//  FcrExamCountdown.swift
//  AgoraProctorUI
//
//  Created by DoubleCircle on 2022/9/8.
//

import AgoraUIBaseViews

protocol FcrExamStartCountdownViewDelegate: NSObjectProtocol {
    func onStartExamTimerStarted()
}

class PtExamStartCountdownView: UIView {
    private lazy var bgImageView = UIImageView()
    private lazy var label = UILabel()
    private var timer: Timer?
    
    private weak var delagate: FcrExamStartCountdownViewDelegate?
    
    convenience init(delegate: FcrExamStartCountdownViewDelegate?) {
        self.init(frame: .zero)
        self.delagate = delegate
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
        initViewFrame()
        updateViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startTimer(countdown: Int,
                    startTime: Int64) {
        guard timer == nil else {
            return
        }
        
        var count = countdown
        
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true,
                                     block: {[weak self] timer in
            guard let `self` = self else {
                return
            }
            
            let realTime = Int64(Date().timeIntervalSince1970 * 1000)
            let beforeLeft = startTime - realTime
            
            guard beforeLeft <= count * 1000 else {
                return
            }
            self.delagate?.onStartExamTimerStarted()
            
            self.agora_visible = true
            self.label.text = "\(count)"
            
            guard countdown > 0 else {
                self.agora_visible = false
                self.stopTimer()
                return
            }
            
            count -= 1
        })
    }
    
    func stopTimer() {
        guard timer != nil else {
            return
        }
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - AgoraUIContentContainer
extension PtExamStartCountdownView: AgoraUIContentContainer {
    func initViews() {
        addSubviews([bgImageView,
                     label])
        
        agora_visible = false
    }
    
    func initViewFrame() {
        bgImageView.mas_makeConstraints { make in
            make?.left.right().top().bottom().equalTo()(0)
        }
        
        label.mas_makeConstraints { make in
            make?.centerX.equalTo()(0)
            make?.bottom.equalTo()(-12)
        }
    }
    
    func updateViewProperties() {
        let config = UIConfig.exam.startCountDown
        
        bgImageView.image = config.image
        label.textColor = config.textColor
        label.font = config.textFont
    }
}
