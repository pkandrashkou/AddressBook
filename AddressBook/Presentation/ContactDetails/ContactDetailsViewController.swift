import UIKit
import RxSwift
import RxCocoa

final class ContactDetailsViewController: UIViewController {
    private let firstName = ContactLabelRow()
    private let lastName = ContactLabelRow()
    private let email = ContactLabelRow()
    private let phoneNumber = ContactLabelRow()
    private let address = ContactLabelRow()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    var viewModel: ContactDetailsViewModel!
    private let disposeBag = DisposeBag()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }

        let stackView = UIStackView()
        stackView.axis = .vertical

        stackView.addArrangedSubview(firstName)
        stackView.addArrangedSubview(lastName)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(phoneNumber)
        stackView.addArrangedSubview(address)

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        address.label.numberOfLines = 0
    }

    private func bindViewModel() {
        viewModel.output.contact.drive(onNext: { [weak self] contact in
            guard let self = self else { return }
            let title = contact.firstName + " " + (contact.lastName ?? "")
            self.navigationItem.title = title
            self.firstName.label.text = contact.firstName

            self.lastName.isHidden = contact.lastName == nil
            self.lastName.label.text = contact.lastName

            self.email.label.text = contact.email
            self.phoneNumber.label.text = contact.phoneNumber

            self.address.label.isHidden = contact.address == nil
            self.address.label.text = contact.address
        }).disposed(by: disposeBag)
    }

    deinit {
        print("deinit ContactDetailsViewController")
    }
}
