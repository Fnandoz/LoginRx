//
//  LoginViewController.swift
//  LoginRx
//
//  Created by Fernando Gomes on 15/09/19.
//  Copyright © 2019 Fernando Gomes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTefField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    var loginVM = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = emailTefField.rx.text.map { $0 ?? "" }.bind(to: loginVM.emailText)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginVM.passwordText)
        
        _ = loginVM.isValid.bind(to: loginButton.rx.isEnabled)
        
        loginVM.isValid.subscribe(onNext: { [unowned self] isValid in
            self.loginStatusLabel.text = isValid ? "Enabled" : "Not enabled"
            self.loginStatusLabel.textColor = isValid ? .green : .red
        }).addDisposableTo(self.disposeBag)
    }

}
