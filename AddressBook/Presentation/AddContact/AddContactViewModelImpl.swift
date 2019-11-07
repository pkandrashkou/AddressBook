import RxSwift
import RxCocoa

final class AddContactViewModel {
    let input: Input
    let output: Output

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

    private let saveSubject = PublishSubject<Void>()
    private let emailEndEditingSubject = PublishSubject<Void>()
    private let cancelSubject = PublishSubject<Void>()

    private let firstNameSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let secondNameSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let emailSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let phoneNumberSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let addressSubject = ReplaySubject<String>.create(bufferSize: 1)

    init(interactor: AddContactInteractor, router: AddContactRouter) {
        let firstNameValidation = firstNameSubject.asObservable()
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

        let emailValidation = emailSubject.asObservable()
            .flatMap { interactor.validate(email: $0).asObservable() }

        let phoneValidation = phoneNumberSubject.asObservable()
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty }

        let requiredFields = Observable.combineLatest(
            firstNameValidation.startWith(false),
            emailValidation.startWith(false),
            phoneValidation.startWith(false)
            )
            .map { isFirstNameValid, isEmailValid, isPhoneValid -> State in
                var invalidaFields: [State.Fields] = []
                if !isFirstNameValid {
                    invalidaFields.append(.firstName)
                }
                if !isEmailValid {
                    invalidaFields.append(.email)
                }
                if !isPhoneValid {
                    invalidaFields.append(.phoneNumber)
                }
                if !invalidaFields.isEmpty {
                    return .requiredFieldsMissing(invalidaFields)
                } else {
                    return .valid
                }
            }

        let state = saveSubject
            .withLatestFrom(requiredFields) { $1 }
            .asDriver(onErrorJustReturn: .empty)

        let isEmailValidEditing = emailEndEditingSubject
            .withLatestFrom(emailValidation)
            .asDriver(onErrorJustReturn: false)

        let form = Observable.combineLatest(
            firstNameSubject.startWith(""),
            secondNameSubject.startWith(""),
            emailSubject.startWith(""),
            phoneNumberSubject.startWith(""),
            addressSubject.startWith("")
            ).map { firstName, lastName, email, phone, address in
                return NewContact(
                    firstName: firstName,
                    lastName: lastName.isEmpty ? nil : lastName,
                    email: email,
                    phoneNumber: phone,
                    address: address.isEmpty ? nil : address
                )
        }

        let saved = saveSubject
            .withLatestFrom(state) { (_, state: State) -> Bool in
                guard case .valid = state else { return false }
                return true
            }
            .skipWhile { $0 == false }
            .withLatestFrom(form) { $1 }
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
    }
}
