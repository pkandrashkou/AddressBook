import RxSwift
import RxCocoa

enum AddContactError: Error {
    case invalidEmail
}

protocol AddContactInteractor {
    func validate(email: String) -> Single<Bool>
    func saveContact(contact: NewContact) -> Single<Contact>
}

final class AddContactInteractorImpl: AddContactInteractor {
    private let contactsRepository: ContactsRepository
    private let emailValidationUseCase: EmailValidationUseCase

    init(contactsRepository: ContactsRepository,
         emailValidationUseCase: EmailValidationUseCase) {
        self.contactsRepository = contactsRepository
        self.emailValidationUseCase = emailValidationUseCase
    }

    func validate(email: String) -> Single<Bool> {
        return Single.create(subscribe: { [weak self] single in
            guard let self = self else {
                single(.success(false))
                return Disposables.create()
            }

            let isValid = self.emailValidationUseCase.validate(email: email)
            single(.success(isValid))
            return Disposables.create()
        })
    }

    func saveContact(contact: NewContact) -> Single<Contact> {
        return contactsRepository.saveContact(contact: contact)
    }

    deinit {
        print("AddContactInteractorImpl")
    }
}
