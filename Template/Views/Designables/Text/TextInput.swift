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
    
    public var body: some View {
        VStack(alignment: .leading) {
            if let title = input.title {
                Text(title)
            }
            
            HStack {
                inputField()
                    .layoutPriority(1)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
            }
            .roundedBorder(Appearance.cornerRadius, color: Color.textSecondary)
            
            if let error = input.error {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(Color.error)
            }
        }
    }
    
    @ViewBuilder
    private func inputField() -> some View {
        switch input.field {
        case .password: 
            SecureField(input.placeholder, text: text)
        case .message(let lineLimit):
            TextField(input.placeholder, text: text, axis: .vertical)
                .lineLimit(lineLimit, reservesSpace: true)
        default:
            TextField(input.placeholder, text: text)
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
