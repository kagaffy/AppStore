import Foundation

enum FixtureError: Error, CustomStringConvertible {
    case missing(String)

    var description: String {
        switch self {
        case let .missing(name):
            "Missing fixture \(name)"
        }
    }
}

func fixture(_ name: String) throws -> Data {
    guard let url = Bundle.module.url(forResource: name, withExtension: "json") else {
        throw FixtureError.missing("\(name).json")
    }
    return try Data(contentsOf: url)
}
