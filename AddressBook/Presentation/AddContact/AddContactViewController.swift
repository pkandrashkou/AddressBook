//
//  AddContactViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/6/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AddContactViewController: UIViewController {
    private let firstNameTextField = ContactTextFieldRow()
    private let lastNameTextField = ContactTextFieldRow()
    private let emailTextField = ContactTextFieldRow()
    private let phoneNumberTextField = ContactTextFieldRow()
    private let addressTextView = ContactTextFieldRow()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private var buttonBottomConstrain: Constraint!
    private var buttonBottomInset: CGFloat = 8
    private let saveButton = UIButton(type: .system)

    var viewModel: AddContactViewModel!
    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical

        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(addressTextView)

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(32)
            buttonBottomConstrain = $0.bottom.equalToSuperview().inset(buttonBottomInset).constraint
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.delaysContentTouches = false
        scrollView.keyboardDismissMode = .interactive

        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.onSave))

        firstNameTextField.textField.placeholder = "First Name"
        lastNameTextField.textField.placeholder = "Last Name"
        emailTextField.textField.placeholder = "Email"
        phoneNumberTextField.textField.placeholder = "Phone"
        addressTextView.textField.placeholder = "Address"

        saveButton.layer.cornerRadius = 5
        saveButton.titleLabel?.font = Font.body
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = Color.teal

        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(self.onViewTap))
        view.addGestureRecognizer(dismissKeyboardTap)

        bindViewModel()
    }

    private func bindViewModel() {
        saveButton.rx.tap
            .bind(to: viewModel.input.saveTrigger)
            .disposed(by: disposeBag)

        emailTextField.textField.rx.controlEvent(.editingDidEnd)
            .bind(to: viewModel.input.endEditingEmail)
            .disposed(by: disposeBag)

        firstNameTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.firstName)
            .disposed(by: disposeBag)
        lastNameTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.secondName)
            .disposed(by: disposeBag)
        emailTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.email)
            .disposed(by: disposeBag)
        phoneNumberTextField.textField.rx.text.orEmpty
            .bind(to: viewModel.input.phoneNumber)
            .disposed(by: disposeBag)
        addressTextView.textField.rx.text.orEmpty
            .bind(to: viewModel.input.address)
            .disposed(by: disposeBag)

        viewModel.output.isEmailValid.drive(onNext: { [weak self] isValid in
            self?.emailTextField.state = isValid ? .normal : .error
        }).disposed(by: disposeBag)

        viewModel.output.state.drive(onNext: { [weak self] state in
            self?.updateState(state: state)
        }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
    }

    deinit {
        print("deinit AddContactViewController")
    }

    func updateState(state: AddContactViewModel.State) {
        /// Apply default state.
        emailTextField.state = .normal
        firstNameTextField.state = .normal
        phoneNumberTextField.state = .normal

        switch state {
        case .empty:
            emailTextField.state = .normal
        case .valid:
            emailTextField.state = .normal
        case .invalidEmail:
            emailTextField.state = .error
        case .requiredFieldsMissing(let fields):
            for field in fields {
                switch field {
                case .email:
                    emailTextField.state = .error
                case .firstName:
                    firstNameTextField.state = .error
                case .phoneNumber:
                    phoneNumberTextField.state = .error
                }
            }
        }
    }
}

private extension AddContactViewController {
    @objc func onClose() {
        view.endEditing(true)
    }

    @objc func onSave() {
        view.endEditing(true)
    }

    @objc func onViewTap() {
        view.endEditing(true)
    }

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardInfo?.cgRectValue.size else { return }

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let curve: UIView.AnimationOptions = curveRaw.map { UIView.AnimationOptions(rawValue: $0) } ?? .curveLinear

        self.view.setNeedsLayout()
        let inset = self.buttonBottomInset + keyboardSize.height
        self.buttonBottomConstrain.update(inset: inset)
        UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let curve: UIView.AnimationOptions = curveRaw.map { UIView.AnimationOptions(rawValue: $0) } ?? .curveLinear

        self.view.setNeedsLayout()
        buttonBottomConstrain.update(inset: buttonBottomInset)
        UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
