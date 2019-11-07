import UIKit
import SnapKit

final class ContactLabelRow: UIView {
    let label = UILabel()
    let separator = SeparatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = Font.body
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-12)
        }

        addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.equalTo(label.snp.leading)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
