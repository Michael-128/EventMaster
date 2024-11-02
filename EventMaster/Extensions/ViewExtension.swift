import SwiftUI

extension View {
    func verticalDismiss(_ state: Binding<Bool> = .constant(false)) -> some View {
        modifier(VerticalDismissModifier(isDragging: state))
    }
    
    func askForApiKey(then onApiKeySet: @escaping () -> Void) -> some View {
        modifier(AskAPIKeyModifier(onApiKeySet: onApiKeySet))
    }
}

