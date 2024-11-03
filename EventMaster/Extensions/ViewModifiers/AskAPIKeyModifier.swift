import SwiftUI

// This view modifier displays a prompt asking for API key if it's not provided
struct AskAPIKeyModifier: ViewModifier {
    public var onApiKeySet: () -> Void
    
    @State private var isApiKeyAlert: Bool = false
    @State private var isApiKeyNotSet: Bool = false
    @State private var apiKey: String = ""
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                if APIService.shared.apiKey != nil { return }
                isApiKeyAlert = true
            }.alert("Wprowadź klucz API", isPresented: $isApiKeyAlert) {
                TextField("Klucz API", text: $apiKey)
                Button("OK", action: { isApiKeyAlert = false; APIService.shared.apiKey = apiKey; onApiKeySet() })
                Button("Anuluj", role: .cancel) { isApiKeyAlert = false; isApiKeyNotSet = true }
            }.alert(isPresented: $isApiKeyNotSet) {
                Alert(title: Text("Brak klucza API"), message: Text("Nie podano klucza API, aplikacja zostanie zakmnięta."), dismissButton: .default(Text("OK")) { fatalError("API key is not set") })
            }
    }
}

    

