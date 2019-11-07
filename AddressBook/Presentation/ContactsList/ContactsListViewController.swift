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
    private let tableView = ContactsListTableView()
    private let noContactsView = ContactsListNoContactsView()

    var viewModel: ContactsListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Address Book"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

        bindViewModel()
    }

    private func bindViewModel() {
        navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: viewModel.input.addContactTrigger)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .do(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .bind(to: viewModel.input.selectTrigger)
            .disposed(by: disposeBag)

        viewModel.output.state
            .drive(onNext: { [weak self] state in
                self?.updateState(state: state)
            }).disposed(by: disposeBag)

        viewModel.output.items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: NSStringFromClass(UITableViewCell.self), cellType: UITableViewCell.self)) { (index, item, cell) in
                cell.textLabel?.font = Font.body
                cell.textLabel?.text = item.title
            }.disposed(by: disposeBag)
    }

    private func updateState(state: ContactsListViewModel.State) {
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
