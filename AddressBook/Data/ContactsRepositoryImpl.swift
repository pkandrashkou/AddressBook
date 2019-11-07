import RealmSwift
import RxSwift
import RxRealm

/// TODO check docs
final class ContactsRepositoryImpl: ContactsRepository {
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    deinit {
        print("ContactsRepositoryImpl")
    }

    func fetchContacts() -> Observable<[Contact]> {
        let contacts = realm.objects(RealmContact.self)
        let check = Observable.collection(from: contacts)
            .map { $0.toArray().map { $0.toDomain() } }
        return check
    }

    func fetchContact(id: String) -> Single<Contact> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.error(ContactsRepositoryError.contactNotFound))
                return Disposables.create()
            }
            guard let fetched = self.realm.object(ofType: RealmContact.self, forPrimaryKey: id) else {
                single(.error(ContactsRepositoryError.contactNotFound))
                return Disposables.create()
            }
            single(.success(fetched.toDomain()))
            return Disposables.create()
        }
    }

    func saveContact(contact: NewContact) -> Single<Contact> {
        return Single.create { [weak self] single in
            guard let self = self else {
                single(.error(ContactsRepositoryError.savingFailed))
                return Disposables.create()
            }
            let realmContact = RealmContact.from(contact: contact)
            do {
                try self.realm.write {
                    self.realm.add(realmContact)
                }
            } catch {
                single(.error(ContactsRepositoryError.underlying(error)))
            }
            guard let created = self.realm.object(ofType: RealmContact.self, forPrimaryKey: realmContact.id) else {
                single(.error(ContactsRepositoryError.savingFailed))
                return Disposables.create()
            }
            single(.success(created.toDomain()))
            return Disposables.create()
        }
    }
}
