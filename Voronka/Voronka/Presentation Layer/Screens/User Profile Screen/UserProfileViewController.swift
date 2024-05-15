//
//  UserProfileViewController.swift
//  Application
//
//  Created by Danil Shvetsov on 18.11.2022.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    // MARK: - Properties.
    
    private let headerTitle = UILabel()
    private var profileCard = UserProfileCard()
    private let tableView = UITableView()
    private let footerLabel = UILabel()
    
    // MARK: - viewDidLoad function.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        if UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.Registered) {
            profileCard.profileImage.image = UIImage(named: "voronka.logo")
        } else {
            profileCard.profileImage.image = UIImage(named: "voronka.logo")
        }
        setupViews()
    }
    
    // MARK: - Status bar setup.
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        super.viewWillAppear(animated)
    }
    
    // MARK: - setupViews function.
    
    private func setupViews() {
        view.backgroundColor = .black
        setupHeaderTitle()
        setupProfileCard()
        setupFooterLabel()
        setupTableView()
    }
    
    // MARK: - setupHeaderTitle function.
    
    private func setupHeaderTitle() {
        headerTitle.text = "Профиль"
        headerTitle.font = AppConstants.Design.Font.Primary.bold(withSize: 17)
        headerTitle.textColor = AppConstants.Design.Color.Primary.White
        headerTitle.textAlignment = .center
        headerTitle.setHeight(to: AppConstants.Design.Size.Small)
        view.addSubview(headerTitle)
        headerTitle.pinCenterX(to: view)
        headerTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, AppConstants.Design.Padding.Medium)
    }
    
    // MARK: - setupProfileCard function.
    
    private func setupProfileCard() {
        self.view.addSubview(profileCard)
        profileCard.pinTop(to: headerTitle.bottomAnchor, AppConstants.Design.Padding.UltraLarge)
        profileCard.pinCenterX(to: self.view.centerXAnchor)
    }
    
    // MARK: - TableView setup.
    
    private func setupTableView() {
        tableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: UserProfileTableViewCell.reuseIdentifier)
        setupTableViewAppearance()
        setupTableViewPosition()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
    }
    
    private func setupTableViewAppearance() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = true
        tableView.indicatorStyle = .white
        tableView.layer.cornerRadius = AppConstants.Design.CornerRadius.Large
    }
    
    private func setupTableViewPosition() {
        view.addSubview(tableView)
        tableView.pinTop(to: profileCard.bottomAnchor, AppConstants.Design.Padding.UltraLarge)
        tableView.pinBottom(to: footerLabel.topAnchor, AppConstants.Design.Padding.Large)
        tableView.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor)
        tableView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    // MARK: - setupFooterLabel function.
    
    private func setupFooterLabel() {
        self.view.addSubview(footerLabel)
        footerLabel.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, AppConstants.Design.Padding.Large)
        footerLabel.pinCenterX(to: self.view.centerXAnchor)
        footerLabel.textColor = AppConstants.Design.Color.Secondary.MediumGray
        footerLabel.font = AppConstants.Design.Font.Primary.bold(withSize: 14)
        footerLabel.text = "Воронка"
        footerLabel.textAlignment = .center
        footerLabel.lineBreakMode = .byWordWrapping
        footerLabel.numberOfLines = .zero
    }
}

// MARK: - Delegate extension.

extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.Registered) {
            switch indexPath.section {
            case 0:
                changeInterestsButtonPressed()
            case 1:
                askQuestionButtonPressed()
            case 2:
                logOutButtonPressed()
            default:
                break
            }
        } else {
            switch indexPath.section {
            case 0:
                askQuestionButtonPressed()
            case 1:
                logOutButtonPressed()
            default:
                break
            }
        }
    }
    
    // MARK: - askQuestionButtonPressed function.
    
    @objc
    private func askQuestionButtonPressed() {
        let askQuestionViewController = AskQuestionViewController()
        let nav = UINavigationController(rootViewController: askQuestionViewController)
        if #available(iOS 16.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.custom { _ in
                    return 200
                }]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = true
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppConstants.Design.CornerRadius.Large
            }
        } else {
            // Fallback on earlier versions
        }
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - logOutButtonPressed function.
    
    @objc
    private func logOutButtonPressed() {
        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultsKeys.Registered)
        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultsKeys.UserId)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(
                UINavigationController( rootViewController: WelcomeViewContorller()))
    }
    
    // MARK: - changeInterestsButtonPressed function.
    
    @objc
    private func changeInterestsButtonPressed() {
        let vc = UserInterestsViewController()
        vc.configure(isRegistration: false)
        let nc = UINavigationController(rootViewController: vc)
        navigationController?.present(nc, animated: true)
    }
}

// MARK: - DataSource extension.

extension UserProfileViewController: UITableViewDataSource {
    
    // MARK: - Setup number of buttons (sections).
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.Registered) {
            return 3
        } else {
            return 2
        }
    }
    
    // MARK: - One button in each section.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Setup button height.
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppConstants.Design.Size.Large
    }
    
    // MARK: - Setup buttons.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.Registered) {
            switch indexPath.section {
            case 0:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    setupCell(profileCell: profileCell, text: "Изменить интересы", imageName: "list.dash")
                    return profileCell
                }
            case 1:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    setupCell(profileCell: profileCell, text: "Задать вопрос", imageName: "questionmark")
                    return profileCell
                }
            case 2:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    setupCell(profileCell: profileCell, text: "Выйти", imageName: "rectangle.portrait.and.arrow.right.red")
                    return profileCell
                }
            default:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    return profileCell
                }
            }
        } else {
            switch indexPath.section {
            case 0:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    setupCell(profileCell: profileCell, text: "Задать вопрос", imageName: "questionmark")
                    return profileCell
                }
            case 1:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    setupCell(profileCell: profileCell, text: "Войти", imageName: "person.fill.badge.plus.blue")
                    return profileCell
                }
            default:
                if let profileCell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier, for: indexPath) as? UserProfileTableViewCell {
                    return profileCell
                }
            }
        }

        return UITableViewCell()
    }
    
    private func setupCell(profileCell: UserProfileTableViewCell, text: String, imageName: String) {
        profileCell.backgroundColor = AppConstants.Design.Color.GrayScale.UltraDark
        profileCell.layer.cornerRadius = AppConstants.Design.CornerRadius.Large
        profileCell.clipsToBounds = true
        profileCell.layer.borderColor = UIColor.black.cgColor
        profileCell.layer.borderWidth = AppConstants.Design.Size.UltraSmall
        profileCell.setText(text: text)
        profileCell.setImage(imageName: imageName)
        profileCell.isUserInteractionEnabled = true
    }
}
