//
//  KeyboardManager.swift
//  Voronka
//
//  Created by Danil Shvetsov on 31.01.2023.
//

import UIKit

import UIKit

enum KeyboardState {
    case up
    case down
}

protocol KeyboardManagerObserver: AnyObject {
    func keyboardStateUpdatedTo(_ keyboardState: KeyboardState, withFrame frame: CGRect)
}

class KeyboardManager {
    static let shared = KeyboardManager()
    
    var observers = [() -> (KeyboardManagerObserver?)]()
    
    let state: KeyboardState = .down
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func addObserver(_ observer: KeyboardManagerObserver) {
        observers.append({ [weak observer] in
            return observer
        })
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            for observer in observers {
                observer()?.keyboardStateUpdatedTo(.up, withFrame: keyboardRectangle)
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            for observer in observers {
                observer()?.keyboardStateUpdatedTo(.down, withFrame: keyboardRectangle)
            }
        }
    }
    
}
