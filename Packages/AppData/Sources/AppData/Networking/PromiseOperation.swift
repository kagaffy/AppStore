import Foundation
import Hydra
import SwiftyJSON

@available(*, deprecated, message: "Replace with async/await clients in Phase 2")
public class PromiseOperation<Value> {
    public var url: URL?
    public var jsonResponse: ((JSON) -> Value)?

    public init() {
        jsonResponse = { _ in
            fatalError("Must implement `jsonResponse` in PromiseOperation subclass.")
        }
    }

    public func execute(in context: Context? = nil) -> Promise<Value> {
        .init(in: context) { resolve, reject, _ in
            URLSession.shared.dataTask(with: self.url!) { data, _, error in
                if let error {
                    reject(error)
                } else if let data {
                    let json = JSON(data)
                    let object = self.jsonResponse!(json)
                    resolve(object)
                }
            }.resume()
        }
    }
}

public class PromiseOperationModel<Value> {
    public var url: URL?
    public var jsonResponse: ((Data) -> Value)?

    public init() {
        jsonResponse = { _ in
            fatalError("Must implement `jsonResponse` in PromiseOperation subclass.")
        }
    }

    public func execute(in context: Context? = nil) -> Promise<Value> {
        .init(in: context) { resolve, reject, _ in
            URLSession.shared.dataTask(with: self.url!) { data, _, error in
                if let error {
                    reject(error)
                } else if let data {
                    let object = self.jsonResponse!(data)
                    resolve(object)
                }
            }.resume()
        }
    }
}
