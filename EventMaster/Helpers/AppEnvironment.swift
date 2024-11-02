import Foundation

enum AppEnvironment {
    static let apiKey: String? = {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            print("API_KEY not set in environment")
            return nil
        }
        return apiKey
    }()
} 
