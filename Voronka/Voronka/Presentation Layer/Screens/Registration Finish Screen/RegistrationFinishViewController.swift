//
//  RegistrationFinishViewController.swift
//  Voronka
//
//  Created by Danil Shvetsov on 04.04.2023.
//

import UIKit
import Gifu

final class RegistrationFinishViewController: UIViewController {
    
    // MARK: - Declaration of all components in controller.
    
    private let welcomeLabel = UILabel()
    
    // MARK: - viewDidLoad function.

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppConstants.Design.Color.Primary.Black
        
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

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - View setup.
    
    private func setupViews() {
        
        setupLabel()
        
        // Tab bar controller setup.
        let tabBarController = MainTabBarViewController()
        tabBarController.viewControllers = [
            UserProfileViewController(
                title: "Профиль",
                image: UIImage(systemName: "person")
            )
        ]
        tabBarController.tabBar.isTranslucent = true
        
        let voronkaGIF = GIFImageView(frame: CGRect(x: 0, y: 0, width: 240, height: 180))
        
        UIView.transition(with: voronkaGIF, duration: 0, options: .transitionCrossDissolve, animations: {
            
            self.view.addSubview(voronkaGIF)
            
            voronkaGIF.pinCenterX(to: self.view)
            voronkaGIF.pinCenterY(to: self.view.centerYAnchor, -50)
            voronkaGIF.setWidth(to: 240)
            voronkaGIF.setHeight(to: 180)
    
            voronkaGIF.animate(
                withGIFNamed: AppConstants.Content.VoronkaRoundGIFName,
                loopCount: 1,
                loopBlock: {
                    self.navigationController?.fadeTo(tabBarController)
                }
            )
            
        }, completion: nil
        )
    }
    
    private func setupLabel() {
        welcomeLabel.text = """
        Добро пожаловать
        в Воронку
        """
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 2
        welcomeLabel.font = AppConstants.Design.Font.Primary.bold(withSize: 27)
        welcomeLabel.textColor = AppConstants.Design.Color.Primary.White
        
        self.view.addSubview(welcomeLabel)
        welcomeLabel.pinCenterX(to: self.view)
        welcomeLabel.pinCenterY(to: self.view.centerYAnchor, 50)
    }
}
