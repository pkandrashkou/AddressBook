//
//  ContactsListViewController.swift
//  AddressBook
//
//  Created by Pavel Kondrashkov on 11/5/19.
//  Copyright © 2019 Touchlane. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit

final class ContactsListViewController: UIViewController {
    private enum State {
        case loading
        case noContacts
        case contacts([Contact])
    }

    private var state: State = .loading {
        didSet {
            updateState(state: state)
        }
    }

    private let tableView = ContactsListTableView()
    private let noContactsView = ContactsListNoContactsView()

    private let viewModel: ContactsListViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: ContactsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var router: ContactsListRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Address Book"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onAddButtonPress))
        updateState(state: .noContacts)


        viewModel.output.contacts
//            .map { contacts -> State in
//                if contacts.isEmpty {
//                    return .noContacts
//                } else {
//                    return .contacts(contacts)
//                }
//            }
//            .bind(to: { (Observable<ContactsListViewController.State>) -> Result in
//                <#code#>
//            })
            .bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)) { (index, contact, cell) in
                cell.textLabel?.font = Font.body
                cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
        }.disposed(by: disposeBag)
    }

    @objc func onAddButtonPress() {
        router.showAddNewContact()
    }

    @objc func onDetailsPress() {
        router.showContactDetails(id: "id")
    }

    private func updateState(state: State) {
        switch state {
        case .loading:
            tableView.removeFromSuperview()
            tableView.snp.removeConstraints()
            noContactsView.removeFromSuperview()
            noContactsView.snp.removeConstraints()
        case .contacts:
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .noContacts:
            view.addSubview(noContactsView)
            noContactsView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.leading.greaterThanOrEqualToSuperview()
                $0.trailing.lessThanOrEqualToSuperview()
            }
        }
    }
}
