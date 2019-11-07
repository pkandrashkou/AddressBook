import RxSwift
import RxCocoa

final class ContactDetailsViewModel {
    private let interactor: ContactDetailsInteractor

    let output: Output
    
    struct Output {
        let contact: Driver<Contact>
    }

    init(id: String, interactor: ContactDetailsInteractor) {
        self.interactor = interactor

        let contact = interactor.fetchContact(id: id)
            .asDriver(onErrorDriveWith: Driver.never())
        output = Output(contact: contact)
    }
}
