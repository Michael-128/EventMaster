import SwiftUI

struct AppLoadingView: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Event").foregroundStyle(.accent)
                Text("Master")
            }.font(.system(size: 48, weight: .bold, design: .default))
        }
    }
}

