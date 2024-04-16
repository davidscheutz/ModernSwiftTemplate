import SwiftUI

public protocol ErrorDisplayable {
    var error: String? { get }
}

extension SimpleTextInput: ErrorDisplayable {}
extension Input: ErrorDisplayable {}

extension View {
    public func animateErrors(_ inputs: [ErrorDisplayable], animation: Animation = .easeInOut) -> some View {
        self.animation(animation, value: inputs.map { $0.error })
    }
}
