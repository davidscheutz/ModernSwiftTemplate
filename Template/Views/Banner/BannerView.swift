import SwiftUI
import SwiftEvolution

struct BannerView: View {
    
    struct Config {
        init(title: String, type: BannerView.MessageType, action: BannerView.Action? = nil) {
            self.title = title
            self.type = type
            self.action = action
        }
        
        let title: String
        let type: MessageType
        let action: Action?
    }
    
    enum MessageType {
        case success
        case info
        case error
        
        fileprivate var iconName: String {
            switch self {
            case .success: return "checkmark.circle.fill"
            case .info: return "info.circle.fill"
            case .error: return "exclamationmark.circle.fill"
            }
        }
    }
    
    struct Action {
        let title: String
        let completion: Completion
        
        static func retry(_ action: @escaping Completion) -> Self {
            .init(title: "Retry", completion: action)
        }
    }
    
    let config: Config
    
    var body: some View {
        HStack {
            Image(systemName: config.type.iconName)
                .imageScale(.medium)
            
            Text(config.title)
            
            Spacer()
            
            if let action = config.action {
                Button(action: action.completion) {
                    Text(action.title)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

#Preview {
    VStack {
        BannerView(config: .init(title: "Success Message", type: .success, action: nil))
        BannerView(config: .init(title: "Info Message", type: .info, action: nil))
        BannerView(config: .init(title: "Error Message", type: .error, action: .retry {}))
    }.padding()
}
