import SwiftUI

struct LoadableListView<T: Identifiable, ItemView: View>: View {
    
    let data: LoadableData<[T]>
    let emptyMessage: String
    @ViewBuilder let renderItem: (T) -> ItemView
    
    init(data: LoadableData<[T]>, emptyMessage: String = "No data available", renderItem: @escaping (T) -> ItemView) {
        self.data = data
        self.emptyMessage = emptyMessage
        self.renderItem = renderItem
    }
    
    var body: some View {
        switch data {
        case .initial:
            EmptyView()
        case .loading:
            ProgressView()
                .stretch()
        case .loaded(let items):
            if items.isEmpty {
                Text(emptyMessage)
                    .foregroundStyle(Color.textSecondary)
                    .stretch()
            } else {
                ScrollView {
                    ForEach(items) {
                        renderItem($0)
                        Divider()
                    }
                }
            }
        case .error(let message):
            Text(message)
                .stretch()
        }
    }
}

// TODO: SwiftEvolution
 extension View {
     // edges: 'horizontal,vertical,all'} = .all
     public func stretch() -> some View {
         frame(maxWidth: .infinity, maxHeight: .infinity)
     }
}
