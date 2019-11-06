//
//  ContactDetailsViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import UIKit

final class ContactDetailsViewController: UIViewController, ContactDetailsCoordinatorProvidable {
    private let firstName = ContactLabelRow()
    private let lastName = ContactLabelRow()
    private let email = ContactLabelRow()
    private let phoneNumber = ContactLabelRow()
    private let address = ContactLabelRow()

    private let scrollView = UIScrollView()
    private let contentView = UIView()


    var coordinator: ContactDetailsCoordinator!

    override func loadView() {
        view = UIView()

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
        view.backgroundColor = .white

        navigationItem.title = "Joshua Smith"
        address.label.numberOfLines = 0

        firstName.label.text = "firstNameLabel firstNameLabel"
        lastName.label.text = "lastNameLabel lastNameLabel"
        email.label.text = "emailLabel emailLabel"
        phoneNumber.label.text = "phoneNumberLabel phoneNumberLabel"
        address.label.text =
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec libero ex, convallis ultricies sodales sed, rhoncus id nisl. Maecenas bibendum neque mollis, lacinia justo in, vulputate mauris. Sed dictum libero eu mi fermentum, et fringilla nibh feugiat. Vestibulum efficitur fringilla fringilla. Proin congue diam sit amet tristique semper. In facilisis iaculis velit. Donec fermentum justo et mauris hendrerit egestas.

        Morbi urna nunc, tempus at magna tincidunt, lobortis euismod neque. Aenean ornare turpis interdum mi molestie, ac elementum neque mollis. In vel tortor justo. Sed volutpat nunc sapien, vel gravida nunc convallis sed. Cras eget lobortis velit. Vestibulum orci velit, ullamcorper sed massa ac, congue facilisis orci. Duis porttitor nibh sit amet finibus euismod. Nunc sodales risus nec aliquet vestibulum. Suspendisse rutrum porta dolor. Quisque consectetur neque risus, sed molestie tortor iaculis nec. Etiam at ultrices nulla. Vestibulum luctus iaculis dui a posuere. Integer aliquet tristique facilisis.

        Aenean egestas ipsum sit amet purus malesuada, quis pulvinar neque ultrices. Duis ullamcorper tempor nunc, id interdum velit accumsan vel. Proin ac mauris ultricies, aliquet velit vel, mollis neque. Integer viverra elit eu mi auctor fringilla. Duis ac pulvinar enim. Morbi vitae ultricies dui. Ut tincidunt augue fringilla, commodo ante nec, venenatis magna.
        """
    }

    deinit {
        print("deinit ContactDetailsViewController")
    }
}
