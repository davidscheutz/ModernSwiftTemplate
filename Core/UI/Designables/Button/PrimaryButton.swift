import SwiftUI

public struct PrimaryButton: View {
    
    let title: String
    let isLoading: Bool
    let action: () -> Void
    
    public init(title: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .style(.subheadline, color: .textInverted)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .opacity(isLoading ? 0 : 1)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .tint(Color.textInverted)
                    }
                }
        }
        .background(.action)
        .cornerRadius(Appearance.cornerRadius)
    }
}

#Preview {
    VStack {
        PrimaryButton(title: "Click Me", action: {})
        PrimaryButton(title: "Click Me", isLoading: true, action: {})
    }
    .padding()
}

