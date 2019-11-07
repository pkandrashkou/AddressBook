import RxSwift

enum ContactsRepositoryError: Error {
    case savingFailed
    case contactNotFound
    case underlying(Error)
}

protocol ContactsRepository {
    func fetchContacts() -> Observable<[Contact]>
    func fetchContact(id: String) -> Single<Contact>
    func saveContact(contact: NewContact) -> Single<Contact>
}
