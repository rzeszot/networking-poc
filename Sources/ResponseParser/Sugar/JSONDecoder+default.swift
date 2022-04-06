import Foundation

extension JSONDecoder {
    public static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.assumesTopLevelDictionary = true
        return decoder
    }
}
