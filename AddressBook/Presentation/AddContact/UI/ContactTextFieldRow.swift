import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ContactTextFieldRow: UIView {
    enum State {
        case normal
        case error
    }

    private let disposeBag = DisposeBag()

    let textField = TextField()
    let clearButton = UIButton(type: .system)
    let separator = SeparatorView()

    var state: State = .normal {
        didSet {
            updateState(state: state)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        textField.autocorrectionType = .no
        textField.font = Font.caption
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(24)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }

        textField.rx.controlEvent(.editingDidBegin)
            .subscribe { [weak self] _ in
                let hasText = self?.textField.text?.isEmpty == false
                self?.clearButton.isHidden = !hasText
            }.disposed(by: disposeBag)

        textField.rx.controlEvent(.editingDidEnd)
            .subscribe { [weak self] _ in
                self?.clearButton.isHidden = true
            }.disposed(by: disposeBag)

        textField.rx
            .controlEvent(.editingChanged)
            .withLatestFrom(textField.rx.text.orEmpty)
            .map { $0.isEmpty == true }
            .subscribe(onNext: { [weak self] isFieldEmpty in
                self?.clearButton.isHidden = isFieldEmpty
                self?.state = .normal
            })
            .disposed(by: disposeBag)

        clearButton.isHidden = true
        clearButton.setImage(UIImage(named: "cancel_cross"), for: .normal)
        clearButton.tintColor = Color.gray2
        clearButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        clearButton.rx.tap.subscribe { [weak self] _ in
            self?.textField.text = ""
            self?.textField.sendActions(for: .valueChanged)
            
            self?.clearButton.isHidden = true
            self?.state = .normal
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
            $0.trailing.equalTo(clearButton.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateState(state: State) {
        switch state {
        case .error:
            separator.backgroundColor = .red
        case .normal:
            separator.backgroundColor = SeparatorView.defaultColor
        }
    }
}

extension ContactTextFieldRow {
    final class TextField: UITextField {
        override var placeholder: String? {
            get { return super.placeholder }
            set {
                guard let newValue = newValue else { return }
                let attributes = [
                    NSAttributedString.Key.foregroundColor: Color.gray2,
                    NSAttributedString.Key.font : Font.caption
                ]
                self.attributedPlaceholder = NSAttributedString(string: newValue, attributes: attributes)
            }
        }
    }
}
