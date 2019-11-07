import UIKit

final class ContactDetailsBuilderImpl: ContactDetailsBuilder {
    private let dependency: ContactDetailsDependency

    init(dependency: ContactDetailsDependency) {
        self.dependency = dependency
    }

    func build(contactId: String) -> UIViewController {
        let view = ContactDetailsViewController()
        let contactsRepository = ContactsRepositoryImpl(realm: dependency.realm)
        let interactor = ContactDetailsInteractorImpl(contactsRepository: contactsRepository)
        view.viewModel = ContactDetailsViewModel(id: contactId, interactor: interactor)
        return view
    }
}
