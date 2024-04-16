import SwiftUI

public struct LoadableView<T, InitialView: View, Result: View>: View {
    
    let data: LoadableData<T>
    let initialView: InitialView
    @ViewBuilder let render: (T) -> Result
    
    public init(
        data: LoadableData<T>,
        @ViewBuilder render: @escaping (T) -> Result
    ) where InitialView == Spacer {
        self.init(data: data, initialView: { Spacer() }, render: render)
    }
    
    public init(
        data: LoadableData<T>,
        initialView: () -> InitialView,
        @ViewBuilder render: @escaping (T) -> Result
    ) {
        self.data = data
        self.initialView = initialView()
        self.render = render
    }
    
    public var body: some View {
        switch data {
        case .initial:
            initialView
        case .loading:
            ProgressView()
                .stretch()
        case .loaded(let item):
            render(item)
        case .error(let message):
            Text(message)
                .stretch()
        }
    }
}
