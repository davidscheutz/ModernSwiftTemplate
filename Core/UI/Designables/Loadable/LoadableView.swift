import SwiftUI

public struct LoadableView<T, Result: View>: View {
    
    let data: LoadableData<T>
    @ViewBuilder let render: (T) -> Result
    
    public init(
        data: LoadableData<T>,
        @ViewBuilder render: @escaping (T) -> Result
    ) {
        self.data = data
        self.render = render
    }
    
    public var body: some View {
        switch data {
        case .initial:
            EmptyView()
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
