//
//  LabeledButton.swift
//  Voronka
//
//  Created by Danil Shvetsov on 05.02.2023.
//

import UIKit

import Combine

final class LabeledButton: UIButton {
    private var buttonStateSubject = CurrentValueSubject<ButtonState, Never>(.disabled)
    private var cancellables = Set<AnyCancellable>()
    
    // UI обновляется автоматически в зависимости от проставленного свойства в buttonState
    var buttonState: ButtonState {
        get { buttonStateSubject.value }
        set { buttonStateSubject.send(newValue) }
    }
    
    init(configuration: Configuration, appearance: Appearance) {
        self.config = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        buttonStateSubject
        .map { [weak self] buttonState -> (() -> Void) in
            switch buttonState {
            case .disabled:
                return { self?.handleDisabledStateChange() }
            case .enabled:
                return { self?.handleEnabledStateChange() }
            case .timer:
                return { self?.handleTimerStateChange() }
            }
        }
        .sink { action in
            action()
        }
        .store(in: &cancellables)
        
        setupUI()
        layout()
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.textColor =
            config.state == .enabled
                ? appearance.enabledTitleColor
                : appearance.disabledTitleColor
        label.text = config.title
        label.textAlignment = .center
        label.font = appearance.titleFont
        
        return label
    }()
    
    private var config: Configuration
    private let appearance: Appearance
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor =
            config.state == .enabled
                ? appearance.enabledButtonColor
                : appearance.disabledButtonColor
        self.layer.cornerRadius = appearance.buttonCornerRadius
        self.layer.masksToBounds = true
        self.isEnabled = config.state != .disabled
        
        self.setHeight(to: appearance.buttonHeight)
    }
    
    private func layout() {
        self.addSubview(title)
        
        title.pinCenter(to: self)
    }
    
    private func updateTitleUI() {
        UIView.animate(withDuration: 0.2, delay: 0.05, animations: {}) { _ in
            UIView.transition(with: self.title, duration: 0.35, options: .transitionCrossDissolve) {
                switch self.buttonState {
                case .disabled:
                    self.title.textColor = self.appearance.disabledTitleColor
                case .enabled:
                    self.title.textColor = self.appearance.enabledTitleColor
                case .timer:
                    self.title.textColor = self.appearance.timerTitleColor
                }
            }
        }
        
    }
    
    private func updateSelfUI() {
        UIView.animate(withDuration: 0.2, delay: 0.05, animations: {}) { _ in
            UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve) {
                switch self.buttonState {
                case .disabled:
                    self.backgroundColor = self.appearance.disabledButtonColor
                case .enabled:
                    self.backgroundColor = self.appearance.enabledButtonColor
                case .timer:
                    self.backgroundColor = self.appearance.timerButtonColor
                }
            }
        }
    }
    
    private func handleDisabledStateChange() {
        self.isEnabled = false
        updateTitleUI()
        updateSelfUI()
    }
        
    private func handleEnabledStateChange() {
        self.isEnabled = true
        updateTitleUI()
        updateSelfUI()
    }
    
    private func handleTimerStateChange() {
        self.isEnabled = false
        updateTitleUI()
        updateSelfUI()
    }
    
    public func setTitleLabelText(text: String) {
        title.text = text
        config.title = text
    }
}

extension LabeledButton {
    
    struct Configuration {
        var title: String
        var state: ButtonState
    }
    
    struct Appearance {
        static let common = Appearance(
            titleFont: AppConstants.Design.Font.Primary.bold(withSize: 16),
            
            disabledTitleColor: AppConstants.Design.Color.GrayScale.Light,
            enabledTitleColor: AppConstants.Design.Color.Primary.White,
            timerTitleColor: AppConstants.Design.Color.GrayScale.Light,
            
            disabledButtonColor: AppConstants.Design.Color.GrayScale.Dark,
            enabledButtonColor: AppConstants.Design.Color.Primary.Blue,
            timerButtonColor: AppConstants.Design.Color.GrayScale.Dark,
            
            buttonCornerRadius: 25,
            buttonHeight: 48
        )
        
        let titleFont: UIFont
        
        let disabledTitleColor: UIColor
        let enabledTitleColor: UIColor
        let timerTitleColor: UIColor
        
        let disabledButtonColor: UIColor
        let enabledButtonColor: UIColor
        let timerButtonColor: UIColor
        
        let buttonCornerRadius: CGFloat
        let buttonHeight: CGFloat
        
    }
    
    func startTimer(time: Int) {
        DispatchQueue.main.async {
            self.buttonState = .timer
            var time = time
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                time -= 1
                if time == 0 {
                    timer.invalidate()
                    self.buttonState = .enabled
                    self.title.text = "Отправить код заново"
                } else {
                    self.title.text = "Отправить код через \(time)"
                }
            }
        }
    }
    
}

extension LabeledButton {
    
    enum ButtonState {
        case disabled
        case enabled
        case timer
        
        public var isAvaliable: Bool {
            switch self {
            case .disabled, .timer:
                return false
            case .enabled:
                return true
            }
        }
    }
}
