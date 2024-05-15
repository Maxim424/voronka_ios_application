//
//  UserPersonalInfoViewController.swift
//  Voronka
//
//  Created by Danil Shvetsov on 05.02.2023.
//

import UIKit

final class UserPersonalInfoViewController: UIViewController {
    
    // MARK: - Declaration of all components in cell.
    
    private let tellAboutYourselfHeader = HeaderScreenTitle(
        configuration: .init(
            text: "Расскажите о себе",
            numberOfLines: 1
        ),
        appearance: .common
    )
    
    private let userAvatarPicker = UserAvatarPicker(
        configuration: .init(
            width: 70,
            height: 70
        ),
        appearance: .common
    )
    
    private let lastNameTextField = LabeledTextField(
        configuration: .init(
            titleText: "Фамилия *",
            placeholder: "Иванова"
        ),
        appearance: .common
    )
    
    private let firstNameTextField = LabeledTextField(
        configuration: .init(
            titleText: "Имя *",
            placeholder: "Полина"
        ),
        appearance: .common
    )
    
    private let dateOfBirthPicker = DateOfBirthPicker(
        configuration: .init(
            text: "Дата рождения",
            placeholder: "Выберите дату рождения"
        ),
        appearance: .common
    )
    
    private let sexPicker = LabeledPicker(
        configuration: .init(
            text: "Пол",
            placeholder: "Выберите пол",
            options: ["мужской", "женский", "не указывать"]
        ),
        appearance: .common
    )
    
    private let usernameTextField = LabeledTextField(
        configuration: .init(
            titleText: "Username",
            placeholder: "@example"
        ),
        appearance: .common
    )
    
    private let bioTextView = ResizableTextView(
        configuration: .init(
            title: "Bio",
            maxHeight: 95,
            isBio: true
        ),
        appearance: .common
    )
    
    private let underlinedViews = UnderlinedViewsStack(
        configuration: .init(
            viewsAmount: 2,
            viewsStates: [.selected, .unselected]
        ),
        appearance: .common
    )
    
    private let furtherButton = LabeledButton(
        configuration: .init(
            title: "Далее",
            state: .enabled
        ),
        appearance: .common
    )
    
    private let scrollView = UIScrollView()
    private let innerView = UIView()
    private let stackView = UIStackView()
    
    private var keyboardHeight: CGFloat = 0
    
    
    // MARK: - viewDidLoad function.

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AppConstants.Design.Color.Primary.Black

        let tapGesture = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        self.view.addGestureRecognizer(tapGesture)
        
        KeyboardManager.shared.addObserver(self)

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

    override func viewDidAppear(_ animated: Bool) {
        
    }


    // MARK: - View setup.

    private func setupViews() {
        setupDownSwipeGesture()
        
        setupTellAboutYourselfHeader()
        
        setupFurtherButton()
        
        setupUnderlinedViews()
        
        setupScrollView()
        
        setupInnerView()
        
        setupStackView()
        
        setupUserAvatarPicker()
        
        setupLastNameTextField()
        
        setupFirstNameTextField()
        
        setupDateOfBirthPicker()
        
        setupSexPicker()
        
        setupUsernameTextField()
        
        setupBioTextView()
        
    }
    
    
    // MARK: - Tell about yourself header setup.
    
    private func setupTellAboutYourselfHeader() {
        self.view.addSubview(tellAboutYourselfHeader)
        
        tellAboutYourselfHeader.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor, 40)
        tellAboutYourselfHeader.pinLeft(to: self.view.safeAreaLayoutGuide.leadingAnchor, 32)
        tellAboutYourselfHeader.pinRight(to: self.view.safeAreaLayoutGuide.trailingAnchor, 32)
    }
    
    
    // MARK: - Further button setup.
    
    private func setupFurtherButton() {
        furtherButton.addTarget(self, action: #selector(furtherButtonPressed(_:)), for: .touchUpInside)
        
        self.view.addSubview(furtherButton)
        
        furtherButton.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 10)
        furtherButton.pinLeft(to: self.view.safeAreaLayoutGuide.leadingAnchor, 16)
        furtherButton.pinRight(to: self.view.safeAreaLayoutGuide.trailingAnchor, 16)
    }
    
    @objc
    private func furtherButtonPressed(_ sender: UIButton) {
        navigationController?.fadeTo(UserInterestsViewController())
    }
    
    
    // MARK: - Underlined views setup.
    
    private func setupUnderlinedViews() {
        self.view.addSubview(underlinedViews)
        
        underlinedViews.pinBottom(to: self.furtherButton.topAnchor, 22)
        underlinedViews.pinLeft(to: self.view.safeAreaLayoutGuide.leadingAnchor, 32)
        underlinedViews.pinRight(to: self.view.safeAreaLayoutGuide.trailingAnchor, 32)
    }
    
    
    // MARK: - Scroll view setup.
    
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        
        self.view.addSubview(scrollView)
        
        scrollView.pinTop(to: self.tellAboutYourselfHeader.bottomAnchor, 32)
        scrollView.pinLeft(to: self.view.safeAreaLayoutGuide.leadingAnchor, 32)
        scrollView.pinRight(to: self.view.safeAreaLayoutGuide.trailingAnchor, 32)
        scrollView.pinBottom(to: self.underlinedViews.topAnchor, 30)
    }
    
    
    // MARK: - Inner view setup.
    
    private func setupInnerView() {
        self.scrollView.addSubview(innerView)
        
        innerView.pin(to: scrollView)

        innerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    
    // MARK: - Stack view setup.
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 15
        
        innerView.addSubview(stackView)
        stackView.pin(to: innerView)
    }
    
    
    // MARK: - User avatar picker setup.
    
    private func setupUserAvatarPicker() {
        userAvatarPicker.setHeight(to: 70)
        
        userAvatarPicker.picker.delegate = self
        userAvatarPicker.addTarget(self, action: #selector(uploadImageButtonPressed(_:)), for: .touchUpInside)
        
        self.stackView.addArrangedSubview(userAvatarPicker)
        stackView.setCustomSpacing(25, after: userAvatarPicker)
    }
    
    @objc
    private func uploadImageButtonPressed(_ sender: UIButton) {
        userAvatarPicker.picker.allowsEditing = false
        userAvatarPicker.picker.sourceType = .photoLibrary
        userAvatarPicker.picker.allowsEditing = false

        self.present(self.userAvatarPicker.picker, animated: true, completion: nil)
    }
    
    
    // MARK: - Last name custom text field setup.
    
    private func setupLastNameTextField() {
        lastNameTextField.textField.addTarget(self, action: #selector(validateInputFieldsDataChanged), for: .editingChanged)

        self.stackView.addArrangedSubview(lastNameTextField)
    }
    
    
    // MARK: - First name custom text field setup.
    
    private func setupFirstNameTextField() {
        firstNameTextField.textField.addTarget(self, action: #selector(validateInputFieldsDataChanged), for: .editingChanged)
        
        self.stackView.addArrangedSubview(firstNameTextField)
    }
    
    
    // MARK: - Date of birth picker setup.
    
    private func setupDateOfBirthPicker() {
        self.stackView.addArrangedSubview(dateOfBirthPicker)
    }
    
    
    // MARK: - Sex picker setup.
    
    private func setupSexPicker() {
        self.stackView.addArrangedSubview(sexPicker)
    }
    
    
    // MARK: - Username custom text field setup.
    
    private func setupUsernameTextField() {
        self.stackView.addArrangedSubview(usernameTextField)
    }

    
    // MARK: - Bio text view setup.
    
    private func setupBioTextView() {
        bioTextView.setHeight(to: 140)
        
        bioTextView.addTarget(self, action: #selector(validateInputFieldsDataChanged), for: .editingChanged)
        
        self.stackView.addArrangedSubview(bioTextView)
    }
    
    
    @objc
    private func validateInputFieldsDataChanged() {
        let isLastNameValid = lastNameTextField.isTextFieldDataValid()
        let isFirstNameValid = firstNameTextField.isTextFieldDataValid()
        
        if isLastNameValid && isFirstNameValid {
            furtherButton.buttonState = .enabled
        } else {
            furtherButton.buttonState = .disabled
        }
        
    }
    
    
    // MARK: - Down swipe gesture setup for ending text field text editing.

    private func setupDownSwipeGesture() {
        let downGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeActionDown(_:))
        )
        downGesture.direction = .down

        self.view.addGestureRecognizer(downGesture)
    }

    @objc
    func swipeActionDown(_ sender: UISwipeGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

extension UserPersonalInfoViewController: KeyboardManagerObserver {
    
    func keyboardStateUpdatedTo(_ keyboardState: KeyboardState, withFrame frame: CGRect) {
        switch keyboardState {
        case .up:
            keyboardHeight = frame.height
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()

            DispatchQueue.main.async {
                self.scrollView.contentInset = .init(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)
            }
        case .down:
            keyboardHeight = 0
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, delay: 0.1) {
                    self.scrollView.contentInset = .zero
                }
                
            }
        }
    }
    
}

extension UserPersonalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userAvatarPicker.image.contentMode = .scaleAspectFill
            userAvatarPicker.image.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
