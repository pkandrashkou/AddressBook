import UIKit
import SnapKit

final class ContactsListNoContactsView: UIView {
    let imageView = UIImageView(image: UIImage(named: "address_book"))
    let mainLabel = UILabel()
    let subLabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.tintColor = Color.gray2
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(imageView.snp.width)
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        mainLabel.textColor = Color.gray2
        mainLabel.textAlignment = .center
        mainLabel.text = L10n.ContactsList.EmptyList.MainLabel.text
        mainLabel.font = Font.headline
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }

        subLabel.textColor = Color.gray2
        subLabel.textAlignment = .center
        subLabel.text = L10n.ContactsList.EmptyList.SubLabel.text
        subLabel.font = Font.body
        addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
