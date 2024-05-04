import SwiftUI
import Combine
import InfiniteNavigation
import SwiftDependencyContainer

/// @Singleton
final class Navigation {
    enum Destination: Hashable {
        case create
        case todo(id: String)
    }
    
    private(set) lazy var publisher = navigateTo.eraseToAnyPublisher()
    
    private let navigateTo = PassthroughSubject<NavAction<Destination>, Never>()
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func openCreateTodo() {
        navigateTo.send(.show(.sheet(.create)))
    }
    
    func openDetail(with id: String) {
        navigateTo.send(.show(.detail(.todo(id: id))))
    }
    
    func closeDetail() {
        navigateTo.send(.pop)
    }
    
    func closeSheet() {
        navigateTo.send(.dismiss)
    }
    
    @ViewBuilder
    func build(_ destination: Destination) -> some View {
        switch destination {
        case .create:
            CreateView.create(using: CreateLoop.create(using: resolver))
        case .todo(let id):
            DetailView.create(using: DetailLoop.create(id: id, using: resolver))
        }
    }
}
