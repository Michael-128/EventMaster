import SwiftUI

struct AskAPIKeyModifier: ViewModifier {
    public var onApiKeySet: () -> Void
    
    @State private var isApiKeyAlert: Bool = false
    @State private var apiKey: String = ""
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                if APIService.shared.apiKey != nil { return }
                isApiKeyAlert = true
            }.alert("Wprowadź klucz API", isPresented: $isApiKeyAlert) {
                TextField("Klucz API", text: $apiKey)
                Button("OK", action: { isApiKeyAlert = false; APIService.shared.apiKey = apiKey; onApiKeySet() })
                Button("Anuluj", role: .cancel) { isApiKeyAlert = false }
            }
    }
}

    

