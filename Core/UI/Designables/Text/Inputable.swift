import Foundation
import SwiftCopy

public protocol Inputable {
    var inputs: [Input] { get }

    // TODO: Add code gen for Inputable.copy function
    func update(inputs: [Input]) -> Self
}

extension Inputable {
    
    public var hasErrors: Bool {
        inputs.hasErrors
    }
    
    public func update(_ value: String, for field: Input.Field, resetError: Bool = true) -> Self {
        update(inputs: inputs.update(value, for: field, resetError: resetError))
    }
    
    public func update(error: String?, for field: Input.Field) -> Self {
        update(inputs: inputs.update(error: error, for: field))
    }
    
    public func validate(field: Input.Field, _ message: String, validate: (String) -> Bool) -> Self {
        update(inputs: inputs.validate(field: field, message, validate: validate))
    }
}

extension Array where Element == Input {
    public var hasErrors: Bool {
        contains { $0.error != nil }
    }
    
    public func value(for field: Input.Field) -> String {
        guard let result = first(where: { $0.field == field }) else {
            fatalError("No input for field: \(field)")
        }
        return result.value
    }
    
    public func update(_ value: String, for field: Input.Field, resetError: Bool) -> [Input] {
        update(for: field, resetError: resetError) { $0.copy(value: value) }
    }
    
    public func update(error: String?, for field: Input.Field) -> [Input] {
        update(for: field, resetError: false) { $0.copy(error: .use(error)) }
    }
    
    public func validate(field: Input.Field, _ error: String, validate: (String) -> Bool) -> Self {
        update(for: field, resetError: false) { $0.copy(error: .use(validate($0.value) ? nil : error)) }
    }
    
    // MARK: - Helper
    
    private func update(for field: Input.Field, resetError: Bool, update: (Input) -> Input) -> [Input] {
        var copy = self
        guard let index = copy.firstIndex(where: { $0.field == field }) else {
            return copy
        }
        copy[index] = update(copy[index]).copy(error: resetError ? .reset : .noChange)
        return copy
    }
}
