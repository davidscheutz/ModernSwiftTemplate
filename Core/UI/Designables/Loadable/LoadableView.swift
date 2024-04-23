import SwiftUI

public struct LoadableView<T, InitialView: View, Result: View>: View {
    
    let data: LoadableData<T>
    @ViewBuilder let render: (T) -> Result
    
    public init(
        data: LoadableData<T>,
        @ViewBuilder render: @escaping (T) -> Result
    ) where InitialView == Spacer {
        self.data = data
        self.render = render
    }
    
    public var body: some View {
        switch data {
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
