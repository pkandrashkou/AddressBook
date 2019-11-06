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

    var router: AddContactRouter! //fix

    override func loadView() {
        view = UIView()

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
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
}

private extension AddContactViewController {
    @objc func onClose() {
        router.close()
    }

    @objc func onSave() {
        router.close()
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
