import SwiftUI
import SwiftEvolution

struct BannerView: View {
    
    let config: Config
    
    var body: some View {
        HStack {
//            Image(systemName: config.type.iconName)
//                .imageScale(.medium)
            
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
