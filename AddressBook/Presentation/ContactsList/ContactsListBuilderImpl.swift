import UIKit

final class ContactsListBuilderImpl: ContactsListBuilder {
    private let dependency: ContactsListDependency

    init(dependency: ContactsListDependency) {
        self.dependency = dependency
    }

    func build() -> UIViewController {
        let view = ContactsListViewController()
        
        let component = ContactsListComponent(dependency: dependency)
        let addContactBuilder = AddContactBuilderImpl(dependency: component)
        let contactDetailsBuilder = ContactDetailsBuilderImpl(dependency: component)

        let navigationScene = NavigationScene(parent: dependency.parent)
        let presentationScene = PresentationScene(parent: dependency.parent)
        let router = ContactsListRouterImpl(
            navigationScene: navigationScene,
            presentationScene: presentationScene,
            addContactBuilder: addContactBuilder,
            contactDetailsBuilder: contactDetailsBuilder
        )

        let contactsRepository = ContactsRepositoryImpl(realm: dependency.realm)
        let interactor = ContactListInteractorImpl(contactsRepository: contactsRepository)
        let viewModel = ContactsListViewModel(interactor: interactor, router: router)
        view.viewModel = viewModel

        return view
    }
}
