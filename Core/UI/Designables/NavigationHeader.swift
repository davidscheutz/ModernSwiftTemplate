import SwiftUI

public struct NavigationHeader: View {
    
    public struct Action {
        public enum Position {
            case left, right
        }
        
        public enum Value: Identifiable {
            case title(String)
            case titleIcon(String, Image)
            case icon(Image)
            case loading
            
            public var id: String {
                switch self {
                case .title(let title):
                    return title
                case .titleIcon(let title, _):
                    return title + "image"
                case .icon(let image):
                    return "\(image)"
                case .loading:
                    return "loading"
                }
            }
        }
        
        public let value: Value
        public let position: Position
        public let perform: Completion
        
        public init(value: Value, position: Position, perform: @escaping Completion) {
            self.value = value
            self.position = position
            self.perform = perform
        }
    }
    
    private let title: String?
    private let actions: [Action]
    
    public init(title: String?, actions: [Action]) {
        self.title = title
        self.actions = actions
    }
    
    public var body: some View {
        HStack {
            actions(for: .left)
            
            Spacer()
            
            actions(for: .right)
        }
        .overlay {
            if let title {
                Text(title)
                    .style(.headlineLarge)
            }
        }
    }
    
    private func actions(for position: Action.Position) -> some View {
        ForEach(actions.filter { $0.position == position }, id: \.value.id) {
            switch $0.value {
            case .title(let title):
                SimpleButton(title, action: $0.perform)
            case .titleIcon(let title, let image):
                HStack(spacing: 4) {
                    renderImage(image, small: true)
                    Text(title)
                        .style(.subheadline, color: .action)
                }.clickable($0.perform)
            case .icon(let image):
                renderImage(image, small: false)
                    .clickable($0.perform)
            case .loading:
                ProgressView()
            }
        }
    }
    
    private func renderImage(_ image: Image, small: Bool) -> some View {
        let size: CGFloat = small ? 16 : 20
        return image
            .renderingMode(.template)
            .resizable()
            .frame(width: size, height: size)
            .foreground(.action)
    }
}

#Preview {
    let leftTitle = NavigationHeader.Action(value: .title("Left"), position: .left, perform: {})
    let leftTitleImage = NavigationHeader.Action(value: .titleIcon("Back", Image(systemName: "arrowshape.backward.fill")), position: .left, perform: {})
    let rightTitle = NavigationHeader.Action(value: .title("Right"), position: .right, perform: {})
    let rightImage = NavigationHeader.Action(value: .icon(Image(systemName: "trash")), position: .right, perform: {})
//    Appearance.setup()
    return VStack(spacing: 30) {
        NavigationHeader(title: nil, actions: [leftTitle])
        NavigationHeader(title: nil, actions: [leftTitleImage])
        NavigationHeader(title: nil, actions: [rightTitle])
        NavigationHeader(title: nil, actions: [rightImage])
        NavigationHeader(title: "Title", actions: [])
        NavigationHeader(title: "Title", actions: [.init(value: .loading, position: .right, perform: {})])
        NavigationHeader(title: "Title", actions: [leftTitle, rightTitle])
    }.padding()
}
