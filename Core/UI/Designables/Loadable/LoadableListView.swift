import SwiftUI
import SwiftEvolution

public struct LoadableListView<T: Identifiable, ItemView: View>: View {
    
    let data: LoadableData<[T]>
    let emptyMessage: String
    @ViewBuilder let renderItem: (T) -> ItemView
    
    public init(data: LoadableData<[T]>, emptyMessage: String = "No data available", renderItem: @escaping (T) -> ItemView) {
        self.data = data
        self.emptyMessage = emptyMessage
        self.renderItem = renderItem
    }
    
    public var body: some View {
        LoadableView(data: data) { items in
            if items.isEmpty {
                Text(emptyMessage)
                    .foreground(.textSecondary)
                    .stretch()
            } else {
                ScrollView {
                    ForEach(items) {
                        renderItem($0)
                        Divider()
                    }
                }
            }
        }
    }
}
