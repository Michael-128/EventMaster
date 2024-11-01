import Foundation

class CustomDateFormatter {
    static let shared = CustomDateFormatter()

    func formatFromISO(date: String) throws -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"

        if let parsedDate = inputFormatter.date(from: date) {
            return outputFormatter.string(from: parsedDate)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Date format is invalid"))
        }
    }
    
    func dateFromISO(date: String) throws -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let parsedDate = inputFormatter.date(from: date) {
            return parsedDate
        }
        
        return nil
    }

    func formatFromISO(date: String, time: String) throws -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"

        if let parsedDate = inputFormatter.date(from: date) {
            let formattedDate = outputFormatter.string(from: parsedDate)
            return "\(time), \(formattedDate)"
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [],
                debugDescription: "Date format is invalid"
            ))
        }
    }
    
    func dateFromISO(date: String, time: String) throws -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm yyyy-MM-dd"
        
        if let parsedDate = inputFormatter.date(from: "\(time) \(date)") {
            return parsedDate
        }
        
        return nil
    }
    
    func formatTime(time: String) -> String {
        let lastColonIndex = time.lastIndex(of: ":")
        
        let startIndex = time.index(time.startIndex, offsetBy: 0)
        let endIndex = time.index(lastColonIndex!, offsetBy: -1)
        
        return String(time[startIndex...endIndex])
    }
}
