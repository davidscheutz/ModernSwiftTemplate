import Foundation
import SwiftUI
import SwiftCopy

public struct SimpleTextInput: Copyable {
    public let value: String
    public let error: String?
    
    public static let empty = SimpleTextInput(value: "", error: nil)
    public static func update(_ value: String) -> SimpleTextInput { .init(value: value, error: nil) }
    
    public init(value: String, error: String? = nil) {
        self.value = value
        self.error = error
    }
}

extension TextInput {
    public init(input: SimpleTextInput, field: Input.Field = .other, title: String? = nil, onChange: @escaping (String) -> Void) {
        self.init(input: Input(field: field, title: title, value: input.value, error: input.error), onChange: onChange)
    }
    
    public init(input: Binding<SimpleTextInput>, field: Input.Field = .other, title: String? = nil) {
        self.init(input: Binding<Input>(
            get: { Input(field: field, title: title, value: input.wrappedValue.value, error: input.wrappedValue.error) },
            set: { input.wrappedValue = SimpleTextInput(value: $0.value, error: $0.error) }
        ))
    }
}
