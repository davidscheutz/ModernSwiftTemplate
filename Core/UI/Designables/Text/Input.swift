import Foundation
import SwiftCopy
import SwiftUI
import SwiftEvolution

public struct Input: Copyable, Identifiable {
    
    public enum Field: Equatable {
        case username
        case password
        case message(lineLimit: Int)
        case other
    }
    
    public let id: String
    public let field: Field
    public let title: String?
    public let placeholder: String
    public let value: String
    public let error: String?
    
    public static func username() -> Input {
        .init(field: .username)
    }
    
    public static func password() -> Input {
        .init(field: .password)
    }
    
    public init(
        id: String = UUID().uuidString,
        field: Input.Field = .other,
        title: String? = nil,
        placeholder: String = .empty,
        value: String = .empty,
        error: String? = nil
    ) {
        self.id = id
        self.field = field
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.error = error
    }
    
    public func update(_ value: String, resetError: Bool = true) -> Self {
        copy(value: value, error: resetError ? .reset : .noChange)
    }
}

extension View {
    public func animateErrors(_ inputs: [Input], animation: Animation = .easeInOut) -> some View {
        self.animation(animation, value: inputs.map { $0.error })
    }
}
