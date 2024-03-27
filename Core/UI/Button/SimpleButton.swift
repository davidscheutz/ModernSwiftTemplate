import SwiftUI

public struct SimpleButton: View {
    
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .style(.subheadline, color: .action)
        }
    }
}

#Preview {
    VStack {
        SimpleButton("Click Me", action: {})
    }
    .padding()
}

