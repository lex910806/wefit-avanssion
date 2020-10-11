//
//  LoginViewController.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import UIKit

protocol AuthenticationControllerProtocol {
    func checkFormStatus()
}

class LoginViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("back", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.text = "Let’s start"
        return label
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.init(246, 29, 68)
        button.setTitleColor(.white, for: .normal)
        button.constrainHeight(constant: 60)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholer: "Email")
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholer: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Not a member ? ",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor:UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Join",
                                                  attributes:[.font : UIFont.boldSystemFont(ofSize: 16),
                                                              .foregroundColor:UIColor.black]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "forgot your password? ",
                                                        attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor:UIColor.black])
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureNotificationObservers()
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email  = emailTextField.text else { return }
        guard let password  = passwordTextField.text else { return }
        let vm = LoginViewModel(email: email, password: password)
        TokenService.post(params: vm) { (token, err) in
            if let _ = err {
                self.toast("Login error")
            } else if let token = token {
                
                let prefs = UserDefaults.standard
                let tokenData = NSKeyedArchiver.archivedData(withRootObject: token)
                prefs.set(tokenData, forKey: "accessToken")
                globalToken = token
                let vc = MainTabBar()
                self.presentViewControllerAsRootVC(with: vc)
            }
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegisterViewController()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
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
        navigationController?.navigationBar.isHidden = true

//        view.addSubview(backButton)
//        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
//                          leading: view.leadingAnchor,
//                          bottom: nil,
//                          trailing: nil,
//                          padding: .init(top: 0, left: 32, bottom: 0, right: 0))
//        
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: nil,
                          padding: .init(top: 50, left: 32, bottom: 0, right: 0))
        
        

        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil,
                                     leading: view.leadingAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     trailing: view.trailingAnchor,
                                     padding: .init(top: 0, left: 32, bottom: 0, right: 32))
        
        let stack = UIStackView(arrangedSubviews: [InputContainerView(textField: emailTextField),
                                                   InputContainerView(textField: passwordTextField),
                                                   forgotPasswordButton,
                                                   loginButton
                                                   ])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: nil,
                     leading: view.leadingAnchor,
                     bottom: dontHaveAccountButton.topAnchor,
                     trailing: view.trailingAnchor,
                     padding: .init(top: 0, left: 32, bottom: 200, right: 32))
        
    }
}


extension LoginViewController: AuthenticationControllerProtocol{
    func checkFormStatus() {
        let formIsValid = viewModel.valid()
        if formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.init(246, 29, 68)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.init(246, 29, 68)
        }
    }
}
