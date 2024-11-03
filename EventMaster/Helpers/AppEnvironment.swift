import Foundation

// This class will load the API key from environment variable and save it securely to keychain.
// If the API key environment variable is not set, it will try to load it from keychain.
// If API_KEY_LOAD is set to false, then the class will not attempt to load the key from keychain. This property should be used for testing purposes.
class AppEnvironment {
    private static let userDefaults = UserDefaults.standard
    private static let apiKeyLoad = Bool(ProcessInfo.processInfo.environment["API_KEY_LOAD"] ?? "true") ?? true
    
    static let apiKey: String? = {
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY"] {
            return setKey(key: apiKey)
        } else if let apiKey = loadKey() {
            return apiKey
        }
        return nil
    }()
    
    static func saveKey(key: String) -> Void {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "com.MikeMichael.EventMaster",
            kSecValueData as String: key.data(using: .utf8)!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        // Delete existing item if it exists (to avoid duplicates)
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new API key to Keychain
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        if status == errSecSuccess {
            print("API key saved to Keychain")
        } else {
            print("Error saving API key to Keychain: \(status)")
        }
    }
    
    static func loadKey() -> String? {
        if apiKeyLoad == false { return nil }
        
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "com.MikeMichael.EventMaster",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            print("Error retrieving API key from Keychain: \(status)")
            return nil
        }
    }
    
    static func setKey(key: String) -> String {
        saveKey(key: key)
        return key
    }
}
