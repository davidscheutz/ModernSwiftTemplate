import Foundation
import SwiftCopy
import SwiftUI
import SwiftEvolution

public struct Input: Copyable, Identifiable {
    
    public enum Field {
        case username
        case password
        case other
    }
    
    public let id: String
    public let field: Field
    public let placeholder: String
    public let value: String
    public let error: String?
    
    public init(
        id: String = UUID().uuidString,
        field: Input.Field,
        placeholder: String = .empty,
        value: String = .empty,
        error: String? = nil
    ) {
        self.id = id
        self.field = field
        self.placeholder = placeholder
        self.value = value
        self.error = error
    }
}

extension View {
    func animateErrors(_ inputs: [Input], animation: Animation = .easeInOut) -> some View {
        self.animation(animation, value: inputs.map { $0.error })
    }
}
