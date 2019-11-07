final class AddContactRouterImpl: AddContactRouter {
    private weak var listener: AddContactListener?

    init(listener: AddContactListener) {
        self.listener = listener
    }

    func close() {
        listener?.onAddedContact()
    }
}
