import RxCocoa
import RxSwift

final class ContactsListViewModel {
    enum State {
        case loading
        case noContacts
        case contacts
    }

    private let interactor: ContactListInteractor
    private let router: ContactsListRouter

    let input: Input
    let output: Output

    struct Input {
        let addContactTrigger: AnyObserver<Void>
        let selectTrigger: AnyObserver<IndexPath>
        let search: AnyObserver<String>
    }

    struct Output {
        let state: Driver<State>
        let items: Driver<[ContactsListTableItem]>
    }

    private let addContactSubject = PublishSubject<Void>()
    private let selectedItemSubject = PublishSubject<IndexPath>()
    private let searchSubject = PublishSubject<String>()

    private let disposeBag = DisposeBag()

    init(interactor: ContactListInteractor,
         router: ContactsListRouter) {
        self.interactor = interactor
        self.router = router

        let contacts = interactor.fetchContacts()
            .share(replay: 1)

        let state = contacts
            .map { contacts -> State in contacts.isEmpty ? .noContacts : .contacts }
            .startWith(.loading)
            .asDriver(onErrorJustReturn: .noContacts)

        let search = searchSubject
            .startWith("")
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)

        let items = contacts
            .map { $0.map { ContactsListTableItem(id: $0.id, title: "\($0.firstName) \($0.lastName ?? "")")} }

        let filteredItems = Observable
            .combineLatest(items, search) { items, filter in
                items.filter{ $0.title.lowercased().hasPrefix(filter.lowercased()) }
            }
            .asDriver(onErrorJustReturn: [])

        selectedItemSubject
            .withLatestFrom(items) { (index: IndexPath, items: [ContactsListTableItem]) -> String? in
                guard items.indices.contains(index.row) else { return nil }
                return items[index.row].id
            }
            .compactMap { $0 }
            .do(onNext: router.showContactDetails)
            .asDriver(onErrorDriveWith: Driver.never())
            .drive()
            .disposed(by: disposeBag)

        addContactSubject
            .do(onNext: router.showAddNewContact)
            .asDriver(onErrorDriveWith: Driver.never())
            .drive().disposed(by: disposeBag)

        output = Output(
            state: state,
            items: filteredItems
        )

        input = Input(
            addContactTrigger: addContactSubject.asObserver(),
            selectTrigger: selectedItemSubject.asObserver(),
            search: searchSubject.asObserver()
        )
    }
}
