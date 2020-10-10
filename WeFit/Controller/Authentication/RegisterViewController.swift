//
//  SignViewController.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import UIKit
import Photos

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?
    
    private let plusPhtoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.clipsToBounds = true
        button.clipsToBounds = true
        return button
    }()
    
    @objc func backButtonHandler() {
        self.dismiss(animated: true)
    }
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("back", for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Enter your account details"
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.constrainHeight(constant: 45)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholer: "Email")
    private let fullNameTextField = CustomTextField(placeholer: "Full Name")
    private let userNameTextField = CustomTextField(placeholer: "User Name")
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholer: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor:UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Log in",
                                                  attributes:[.font : UIFont.boldSystemFont(ofSize: 16),
                                                              .foregroundColor:UIColor.black]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Selectors
    var fileName: String?
    @objc func handleRegistration() {
        guard let email  = emailTextField.text else { return }
        guard let password  = passwordTextField.text else { return }
        guard let fullname  = fullNameTextField.text else { return }
        guard let username  = userNameTextField.text?.lowercased() else { return }
//        guard let profileImage  = profileImage else { return }
        
        let vm = UserViewModel(email: email, password: password, avatar: profileImage ?? UIImage(), firstName: fullname, lastName: fullname, nickName: username, birth: 1970, height: 180, weight: 70, sex: .male, imageName: fileName ?? "")
        UserService.upload(params: vm) { (tuple, err)  in
            
            let (id, avatar) = tuple
            if err != nil {
                self.toast("우리서버 오류")
                return
            }
            if let id = id {
                let credential = RegistrationCredentials(id: id, email: email, name: fullname, nickName: username, avatar: avatar ?? "")
                UserService.createUser(credentials: credential) { (err) in
                    if let err = err {
                        self.toast("파이어베이스 오류")
                        
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        } else if sender == userNameTextField {
            viewModel.username = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin(){
        self.dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(){
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide(){
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: nil,
                          padding: .init(top: 0, left: 32, bottom: 0, right: 0))
        
        
//        view.addSubview(titleLabel)
//        titleLabel.anchor(top: backButton.bottomAnchor,
//                          leading: view.leadingAnchor,
//                          bottom: nil,
//                          trailing: nil,
//                          padding: .init(top: 50, left: 32, bottom: 0, right: 0))
        
        
        view.addSubview(plusPhtoButton)
        plusPhtoButton.centerXInSuperview()
        plusPhtoButton.anchor(top: backButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil,
                              padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                              size: .init(width: 200, height: 200))
        
        
        let stack = UIStackView(arrangedSubviews: [InputContainerView(textField: emailTextField),
                                                   InputContainerView(textField: userNameTextField),
                                                   InputContainerView(textField: fullNameTextField),
                                                   InputContainerView(textField: passwordTextField),
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: plusPhtoButton.bottomAnchor,
                     leading: view.leadingAnchor,
                     bottom: nil,
                     trailing: view.trailingAnchor,
                     padding: .init(top: 32, left: 32, bottom: 0, right: 32))


        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil,
                                        leading: view.leadingAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        trailing: view.trailingAnchor,
                                        padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        if let asset = info[.phAsset] as? PHAsset {
            let assetResources = PHAssetResource.assetResources(for: asset)
            fileName = assetResources.first?.originalFilename
        }
        profileImage = image
        plusPhtoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhtoButton.layer.borderColor = UIColor.white.cgColor
        plusPhtoButton.layer.borderWidth = 3.0
        plusPhtoButton.layer.cornerRadius = 200 / 2
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: AuthenticationControllerProtocol{
    func checkFormStatus() {
        let formIsValid = viewModel.valid()
        if formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .black
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .darkGray
        }
    }
}

