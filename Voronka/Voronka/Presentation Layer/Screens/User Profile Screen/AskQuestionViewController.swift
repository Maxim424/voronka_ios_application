//
//  AskQuestionViewController.swift
//  Voronka
//
//  Created by Максим Кузнецов on 20.04.2023.
//

import UIKit

final class AskQuestionViewController: UIViewController {
    
    // MARK: - Properties.
    
    private let textView = UITextView()
    
    // MARK: - viewDidLoad function.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppConstants.Design.Color.GrayScale.Dark
        setupViews()
    }
    
    // MARK: - viewDidLayoutSubviews function.
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Status bar setup.
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Navigation bar appear & disappear status.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Views setup.
    
    private func setupViews() {
        setupTextView()
        setupImage()
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.pinTop(to: view, 16)
        textView.pinBottom(to: view.centerYAnchor)
        textView.pinLeft(to: view, 16)
        textView.pinRight(to: view, 16)
        
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = AppConstants.Design.Color.Primary.White
        textView.font = AppConstants.Design.Font.Primary.regular(withSize: 18)
        let text = """
                    Если у вас появился вопрос, предложение о сотрудничестве или возникла какая-то ошибка, пишите в наш [Telegram-бот](https://t.me/voronka_app_bot)
                    """
        
        if #available(iOS 15, *) {
            do {
                textView.attributedText = NSAttributedString(try AttributedString(styledMarkdown: text, fontSize: 14))
            } catch {
                textView.text = text
            }
        } else {
            textView.text = text
        }
    }
    
    private func setupImage() {
        let image = UIImageView(image: UIImage(named: "voronka_welcome"))
        image.setWidth(to: 217.1)
        image.setHeight(to: 84.5)
        view.addSubview(image)
        image.pinTop(to: view.centerYAnchor)
        image.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - Views setup.
    
    @objc
    private func closeSheet() {
        dismiss(animated: true)
    }
}

