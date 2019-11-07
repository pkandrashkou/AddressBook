import RxSwift
import RxCocoa

final class AddContactViewModel {
    enum State {
        enum Fields {
            case firstName
            case phoneNumber
            case email
        }

        case empty
        case valid
        case requiredFieldsMissing([Fields])
    }
    
    private let interactor: AddContactInteractor
    private let router: AddContactRouter

    private let saveSubject = PublishSubject<Void>()
    private let emailEndEditingSubject = PublishSubject<Void>()
    private let cancelSubject = PublishSubject<Void>()

    private let firstNameSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let secondNameSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let emailSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let phoneNumberSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let addressSubject = ReplaySubject<String>.create(bufferSize: 1)

    var input: Input!
    var output: Output!

    struct Input {
        let saveTrigger: AnyObserver<Void>
        let endEditingEmail: AnyObserver<Void>
        let cancelTrigger: AnyObserver<Void>

        let firstName: AnyObserver<String>
        let secondName: AnyObserver<String>
        let email: AnyObserver<String>
        let phoneNumber: AnyObserver<String>
        let address: AnyObserver<String>
    }

    struct Output {
        let state: Driver<State>
        let isEmailValid: Driver<Bool>
        let closed: Driver<Void>
    }

    init(interactor: AddContactInteractor, router: AddContactRouter) {
        self.interactor = interactor
        self.router = router

        input = Input(
            saveTrigger: saveSubject.asObserver(),
            endEditingEmail: emailEndEditingSubject.asObserver(),
            cancelTrigger: cancelSubject.asObserver(),
            firstName: firstNameSubject.asObserver(),
            secondName: secondNameSubject.asObserver(),
            email: emailSubject.asObserver(),
            phoneNumber: phoneNumberSubject.asObserver(),
            address: addressSubject.asObserver()
        )

        let requiredFields = requiredFieldsState(
            firstName: firstNameSubject.asObservable(),
            email: emailSubject.asObservable(),
            phone: phoneNumberSubject.asObservable(),
            emailValidator: interactor.validate
        )

        let state = saveSubject
            .withLatestFrom(requiredFields) { $1 }
            .asDriver(onErrorJustReturn: .empty)

        let isEmailValidEditing = emailEndEditingSubject
            .withLatestFrom(emailSubject.flatMap { interactor.validate(email: $0) })
            .asDriver(onErrorJustReturn: false)

        let newContact = self.newContact(
            firstName: firstNameSubject.asObservable(),
            secondName: secondNameSubject.asObservable(),
            email: emailSubject.asObservable(),
            phoneNumber: phoneNumberSubject.asObservable(),
            address: addressSubject.asObservable()
        )

        let saved = saveSubject
            .withLatestFrom(state) { (_, state: State) -> Bool in
                guard case .valid = state else { return false }
                return true
            }
            .skipWhile { $0 == false }
            .withLatestFrom(newContact) { $1 }
            .flatMap { interactor.saveContact(contact: $0) }
            .map { _ in return () }
            .do(onNext: {
                router.close()
            })
            .asDriver(onErrorDriveWith: Driver.never())

        let canceled = cancelSubject
            .do(onNext: { _ in
                router.close()
            })
            .asDriver(onErrorDriveWith: Driver.never())

        output = Output(
            state: state,
            isEmailValid: isEmailValidEditing,
            closed: Driver.merge(saved, canceled)
        )
    }
}

private extension AddContactViewModel {
    func requiredFieldsState(firstName: Observable<String>,
                                     email: Observable<String>,
                                     phone: Observable<String>,
                                     emailValidator: @escaping (_ email: String) -> Single<Bool>) -> Observable<State> {
        let firstNameValidation = firstName
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        let emailValidation = email
            .flatMap { emailValidator($0) }
        let phoneValidation = phoneNumberSubject.asObservable()
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

        return Observable.combineLatest(
            firstNameValidation.startWith(false),
            emailValidation.startWith(false),
            phoneValidation.startWith(false)
            )
            .map { isFirstNameValid, isEmailValid, isPhoneValid -> State in
                var invalidaFields: [State.Fields] = []
                if !isFirstNameValid { invalidaFields.append(.firstName) }
                if !isEmailValid { invalidaFields.append(.email) }
                if !isPhoneValid { invalidaFields.append(.phoneNumber) }
                guard invalidaFields.isEmpty else {
                    return .requiredFieldsMissing(invalidaFields)
                }
                return .valid
            }.share(replay: 1)
    }

    func newContact(firstName: Observable<String>,
                            secondName: Observable<String>,
                            email: Observable<String>,
                            phoneNumber: Observable<String>,
                            address: Observable<String>) -> Observable<NewContact> {
        return Observable.combineLatest(
            firstName.startWith(""),
            secondName.startWith(""),
            email.startWith(""),
            phoneNumber.startWith(""),
            address.startWith("")
            ).map { firstName, lastName, email, phone, address in
                return NewContact(
                    firstName: firstName,
                    lastName: lastName.isEmpty ? nil : lastName,
                    email: email,
                    phoneNumber: phone,
                    address: address.isEmpty ? nil : address
                )
            }.share(replay: 1)
    }

}
