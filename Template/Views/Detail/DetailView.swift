import SwiftUI
import SwiftUDF
import SwiftEvolution

struct DetailView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    DetailView()
//}
