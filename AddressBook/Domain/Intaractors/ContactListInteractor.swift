import RxSwift

protocol ContactListInteractor {
    func fetchContacts() -> Observable<[Contact]>
}

final class ContactListInteractorImpl: ContactListInteractor {
    private let contactsRepository: ContactsRepository

    init(contactsRepository: ContactsRepository) {
        self.contactsRepository = contactsRepository
    }

    func fetchContacts() -> Observable<[Contact]> {
        return contactsRepository.fetchContacts()
    }
}
