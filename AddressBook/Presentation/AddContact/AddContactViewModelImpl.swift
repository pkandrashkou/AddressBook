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
        case invalidEmail
        case requiredFieldsMissing([Fields])
    }

    struct Input {
        let saveTrigger: AnyObserver<Void>
        let endEditingEmail: AnyObserver<Void>

        let firstName: AnyObserver<String>
        let secondName: AnyObserver<String>
        let email: AnyObserver<String>
        let phoneNumber: AnyObserver<String>
        let address: AnyObserver<String>
    }

    struct Output {
        let state: Driver<State>
        let isEmailValid: Driver<Bool>
    }

    private let saveSubject = PublishSubject<Void>()
    private let emailEndEditingSubject = PublishSubject<Void>()

    private let firstNameSubject = PublishSubject<String>()
    private let secondNameSubject = PublishSubject<String>()
    private let emailSubject = PublishSubject<String>()
    private let phoneNumberSubject = PublishSubject<String>()
    private let addressSubject = PublishSubject<String>()


    init(interactor: AddContactInteractor, router: AddContactRouter) {
        let firstNameValidation = firstNameSubject.asObservable()
//            .skipWhile { $0.isEmpty }
//            .distinctUntilChanged()
            .map { name -> Bool in
                print("name", !name.trimmingCharacters(in: .whitespaces).isEmpty)
                return !name.trimmingCharacters(in: .whitespaces).isEmpty
        }

        let emailValidation = emailSubject.asObservable()
//            .skipWhile { $0.isEmpty }
//            .distinctUntilChanged()
            .flatMap { interactor.validate(email: $0).asObservable() }

        let phoneValidation = phoneNumberSubject.asObservable()
//            .skipWhile { $0.isEmpty }
//            .distinctUntilChanged()
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty }


        let requiredFields = Observable.combineLatest(
            firstNameValidation.startWith(false),
            emailValidation.startWith(false),
            phoneValidation.startWith(false)
            )
//            .skip(1)
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
//            .asDriver(onErrorJustReturn: .empty)


        let state = saveSubject
            .withLatestFrom(requiredFields) { $1 }
            .asDriver(onErrorJustReturn: .empty)
            .debug("state")

//        let state = requiredFields
//            .withLatestFrom(saveSubject, resultSelector: { (state: AddContactViewModel.State, void: Void) -> AddContactViewModel.State in
//                return state
//            })
////            .withLatestFrom(saveSubject.asObservable(), resultSelector: { $0 })
//            .asDriver(onErrorJustReturn: .empty)
//            .debug("state")



        let isEmailValidEditing = emailEndEditingSubject
            .withLatestFrom(emailValidation)
            .asDriver(onErrorJustReturn: false)
            .debug("isEmailValidEditing")

        output = Output(
            state: state,
            isEmailValid: isEmailValidEditing
        )

        input = Input(
            saveTrigger: saveSubject.asObserver(),
            endEditingEmail: emailEndEditingSubject.asObserver(),
            firstName: firstNameSubject.asObserver(),
            secondName: secondNameSubject.asObserver(),
            email: emailSubject.asObserver(),
            phoneNumber: phoneNumberSubject.asObserver(),
            address: addressSubject.asObserver()
        )
    }
}
