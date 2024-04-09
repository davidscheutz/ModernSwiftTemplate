import Foundation
import SwiftUI

public struct SimpleTextInput {
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
    public init(input: SimpleTextInput, onChange: @escaping (String) -> Void) {
        self.init(input: Input(value: input.value, error: input.error), onChange: onChange)
    }
    
    public init(input: Binding<SimpleTextInput>) {
        self.init(input: Binding<Input>(
            get: { Input(value: input.wrappedValue.value, error: input.wrappedValue.error) },
            set: { input.wrappedValue = SimpleTextInput(value: $0.value, error: $0.error) }
        ))
    }
}
