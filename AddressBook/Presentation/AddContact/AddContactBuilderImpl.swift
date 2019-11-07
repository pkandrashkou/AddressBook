import UIKit

final class AddContactBuilderImpl: AddContactBuilder {
    private let dependency: AddContactDependency

    init(dependency: AddContactDependency) {
        self.dependency = dependency
    }

    func build(listener: AddContactListener) -> UIViewController {
        let view = AddContactViewController()
        let container = SolidNavigationController()
        container.viewControllers = [view]
        let router = AddContactRouterImpl(listener: listener)
        let contactsRepository = ContactsRepositoryImpl(realm: dependency.realm)
        let emailValidationUseCase = EmailValidationUseCaseImpl()
        let interactor = AddContactInteractorImpl(contactsRepository: contactsRepository, emailValidationUseCase: emailValidationUseCase)
        let viewModel = AddContactViewModel(interactor: interactor, router: router)
        view.viewModel = viewModel
        return container
    }
}
