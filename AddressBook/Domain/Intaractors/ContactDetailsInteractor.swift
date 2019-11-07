import RxSwift

protocol ContactDetailsInteractor {
    func fetchContact(id: String) -> Single<Contact>
}

final class ContactDetailsInteractorImpl: ContactDetailsInteractor {
    private let contactsRepository: ContactsRepository

    init(contactsRepository: ContactsRepository) {
        self.contactsRepository = contactsRepository
    }

    func fetchContact(id: String) -> Single<Contact> {
        return contactsRepository.fetchContact(id: id)
    }
}
