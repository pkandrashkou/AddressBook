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

final class ContactTextField: UIView {
    private let disposeBag = DisposeBag()
    let textField = UITextField()
    let clearButton = UIButton(type: .system)
    let separator = SeparatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        textField.autocorrectionType = .no
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }

        textField.rx.text.orEmpty
            .map { $0.isEmpty == true }
            .subscribe(onNext: { [weak self] isFieldEmpty in
                self?.clearButton.isHidden = isFieldEmpty
            }).disposed(by: disposeBag)

        clearButton.setImage(UIImage(named: "cancel_cross"), for: .normal)
        clearButton.tintColor = UIColor(red: 174 / 255, green: 174 / 255, blue: 178 / 255, alpha: 1)
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        clearButton.rx.tap.subscribe { [weak self] _ in
            self?.textField.text = ""
            self?.clearButton.isHidden = true
        }.disposed(by: disposeBag)

        addSubview(clearButton)
        clearButton.snp.makeConstraints {
            $0.leading.equalTo(textField.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
            $0.trailing.equalToSuperview().offset(-16)
        }

        addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.equalTo(textField.snp.leading)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 229 / 255, green: 229 / 255, blue: 234 / 255, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 1)
    }
}

final class AddContactViewController: UIViewController {
    private lazy var firstNameTextField: ContactTextField  = {
        let field = ContactTextField()
        field.textField.placeholder = "First Name"
        return field
    }()

    private let lastNameTextField: ContactTextField  = {
        let field = ContactTextField()
        field.textField.placeholder = "Last Name"
        return field
    }()

    private let emailTextField: ContactTextField  = {
        let field = ContactTextField()
        field.textField.placeholder = "Email"
        return field
    }()

    private let phoneNumberTextField: ContactTextField  = {
        let field = ContactTextField()
        field.textField.placeholder = "Phone Number"
        return field
    }()

    /// TODO: add keyboard types
    private let addressTextView: ContactTextField  = {
        let field = ContactTextField()
        field.textField.placeholder = "Address"
        field.separator.isHidden = true
        return field
    }()

    let scrollView = UIScrollView()
    let contentView = UIView()

    var buttonBottomConstrain: Constraint!
    var buttonBottomInset: CGFloat = 8
    let saveButton = UIButton()

    var router: AddContactRouter! //fix

    override func loadView() {
        view = UIView()

        scrollView.keyboardDismissMode = .interactive
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
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
        stackView.addArrangedSubview(SeparatorView())

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        saveButton.backgroundColor = .red
        contentView.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(32)
            buttonBottomConstrain = $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).inset(buttonBottomInset).constraint
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "New Contact"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.onClose))

        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(self.onViewTap))
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

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

    deinit {
        print("deinit AddContactViewController")
    }


    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        guard let keyboardSize = keyboardInfo?.cgRectValue.size else { return }


        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        let curve: UIView.AnimationOptions = curveRaw.map { UIView.AnimationOptions(rawValue: $0) } ?? .curveLinear

        self.view.setNeedsLayout()
        self.buttonBottomConstrain.update(inset: self.buttonBottomInset + keyboardSize.height)
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

    @objc func onClose() {
        router.close()
    }

    @objc func onViewTap() {
        view.endEditing(true)
    }
}
