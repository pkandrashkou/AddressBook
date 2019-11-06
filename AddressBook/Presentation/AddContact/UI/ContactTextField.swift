//
//  ContactTextField.swift
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
        clearButton.tintColor = Color.gray2
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
