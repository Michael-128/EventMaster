import Foundation

enum AppEnvironment {
    static let apiKey: String = {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("API_KEY not set in environment")
        }
        return apiKey
    }()
} 
