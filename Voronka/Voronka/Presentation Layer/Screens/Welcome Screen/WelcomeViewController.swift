//
//  WelcomeViewController.swift
//  Voronka
//
//  Created by Danil Shvetsov on 27.01.2023.
//

import UIKit
import Gifu

/// View controller for welcome screen.
final class WelcomeViewContorller: UIViewController {
    
    // MARK: - Declaration of all components in controller.
    
    // Voronka find communnity background GIF animation.
    private var voronkaFindCommunityBackgroundGIF = GIFImageView()
    
    // Voronka label image view.
    private let voronkaImageView = UIImageView(image: UIImage(named: "voronka_welcome"))
    
    // ELK_HSE login button.
    private let loginELKButton = UIButton()
    private let loginELKLabel = UILabel()

    // MARK: - View controller life cycle && service functions.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConstants.Design.Color.Primary.Black
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Views setup.
    
    private func setupViews() {
        setupVoronkaGIF()
        setupLoginELKButton()
    }
    
    
    // MARK: - Voronka round GIF setup.
    
    private func setupVoronkaGIF() {
        voronkaFindCommunityBackgroundGIF = GIFImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        voronkaFindCommunityBackgroundGIF.animate(
            withGIFNamed: AppConstants.Content.FindCommunityBackgroundGIFName,
            loopBlock:  {}
        )
        
        self.view.addSubview(voronkaFindCommunityBackgroundGIF)
        
        voronkaFindCommunityBackgroundGIF.pin(to: self.view, [.left, .bottom, .right, .top])
    }
    
    
    private func setupVoronkaWelcomeImageView() {
        self.view.addSubview(voronkaImageView)
        
        voronkaImageView.pinCenterX(to: self.view)
        voronkaImageView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor, 80)
    }
    

    // MARK: - Login ELK button setup.
    
    private func setupLoginELKButton() {
        setupLoginELKButtonAppearance()
        setupLoginELKButtonPosition()
        
        loginELKButton.addTarget(
            self,
            action: #selector(loginELKButtonPressed(_:)),
            for: .touchUpInside
        )
    }
    
    private func setupLoginELKButtonAppearance() {
        loginELKButton.backgroundColor = AppConstants.Design.Color.Primary.Blue
        loginELKButton.layer.cornerRadius = 25
        
        setupLoginELKLabel()
    }
    
    private func setupLoginELKButtonPosition() {
        self.view.addSubview(loginELKButton)
        
        loginELKButton.pinBottom(
            to: self.view.safeAreaLayoutGuide.bottomAnchor,
            80
        )
        loginELKButton.pinLeft(
            to: self.view.safeAreaLayoutGuide.leadingAnchor,
            16
        )
        loginELKButton.pinRight(
            to: self.view.safeAreaLayoutGuide.trailingAnchor,
            16
        )
        
        loginELKButton.setHeight(to: 48)
    }
    
    private func setupLoginELKLabel() {
        loginELKLabel.text = "Войти"
        loginELKLabel.textColor = AppConstants.Design.Color.Primary.White
        loginELKLabel.numberOfLines = 1
        loginELKLabel.textAlignment = .center
        loginELKLabel.font = AppConstants.Design.Font.Primary.bold(withSize: 16)
        
        self.loginELKButton.addSubview(loginELKLabel)
        
        loginELKLabel.pinCenter(to: self.loginELKButton)
    }
    
    @objc
    private func loginELKButtonPressed(_ sender: UIButton) {
        navigationController?.fadeTo(UserPersonalInfoViewController())
    }
}
