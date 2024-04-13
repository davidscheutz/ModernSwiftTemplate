import SwiftUI
import SwiftEvolution

public struct TextInput: View {
    
    private let input: Input
    private let text: Binding<String>
    
    public init(input: Input, onChange: @escaping (Input.Field, String) -> Void) {
        self.input = input
        text = .init(get: { input.value }, set: { onChange(input.field, $0) })
    }
    
    public init(input: Input, onChange: @escaping (String) -> Void) {
        self.input = input
        text = .init(get: { input.value }, set: { onChange($0) })
    }
    
    public init(input: Binding<Input>) {
        self.input = input.wrappedValue
        self.text = .init(
            get: { input.wrappedValue.value },
            set: { input.wrappedValue = input.wrappedValue.copy(value: $0) }
        )
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title = input.title {
                Text(title)
                    .style(.body)
            }
            
            HStack {
                inputField()
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
            }
            .frame(minHeight: 46)
            .roundedBorder(Appearance.cornerRadius, color: Color.textSecondary)
            
            if let error = input.error {
                Text(error)
                    .style(.footnote, color: .error)
            }
        }
    }
    
    @ViewBuilder
    private func inputField() -> some View {
        switch input.field {
        case .password: 
            SecureField(input.placeholder, text: text)
                .style()
        case .message(let lineLimit):
            if #available(iOS 16.0, *) {
                TextField(input.placeholder, text: text, axis: .vertical)
                    .style()
                    .lineLimit(lineLimit, reservesSpace: true)
            } else {
                // Fallback on earlier versions
            }
        default:
            TextField(input.placeholder, text: text)
                .style()
        }
    }
}

#Preview {
    VStack {
        TextInput(input: .init(field: .username, placeholder: "username"), onChange: { _, _ in })
        TextInput(input: .init(field: .password, value: "secret"), onChange: { _, _ in })
        TextInput(input: .init(field: .username, title: "Username", error: "empty input"), onChange: { _, _ in })
        TextInput(input: .init(field: .message(lineLimit: 5), placeholder: "add your feedback"), onChange: { _, _ in })
    }
    .padding()
}
