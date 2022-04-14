import XCTest
import Hated

final class HatedTests: XCTestCase {

    func test_encode() throws {
        let account = Account(number: "12345", balance: Money(amount: 150.00, currency: "USD"))
        let links = Account.Links(account: account)

        let hated = Hated<Account, Account.Links>(object: account, links: links)
        let sut = try encode(value: hated)

        XCTAssertEqual(sut, .account)
    }

    func test_decode() throws {
        let json = String.account

        let sut: Hated<Account, Account.Links> = try decode(string: json)

        XCTAssertEqual(sut.object.number, "12345")
        XCTAssertEqual(sut.object.balance.amount, 150)
        XCTAssertEqual(sut.object.balance.currency, "USD")

        XCTAssertEqual(sut.links.deposit.absoluteString, "/account/12345/deposit")
        XCTAssertEqual(sut.links.withdraw.absoluteString, "/account/12345/withdraw")
    }

    // MARK: -

    func encode<T: Encodable>(value: T, using encoder: JSONEncoder = .test) throws -> String {
        String(data: try encoder.encode(value), encoding: .utf8)!
    }

    func decode<T: Decodable>(string: String, using decoder: JSONDecoder = .init()) throws -> T {
        try decoder.decode(T.self, from: string.data(using: .utf8)!)
    }

}

struct Money: Codable {
    let amount: Decimal
    let currency: String
}

struct Account: Codable {
    let number: String
    let balance: Money
}

extension Account {
    struct Links: Codable {
        let deposit: URL
        let withdraw: URL

        init(account: Account) {
            deposit = URL(string: "/account/\(account.number)/deposit")!
            withdraw = URL(string: "/account/\(account.number)/withdraw")!
        }
    }
}

extension String {
    static let account = """
        {
          "balance" : {
            "amount" : 150,
            "currency" : "USD"
          },
          "links" : {
            "deposit" : "/account/12345/deposit",
            "withdraw" : "/account/12345/withdraw"
          },
          "number" : "12345"
        }
        """
}

extension JSONEncoder {
    static let test: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [
            .sortedKeys,
            .prettyPrinted,
            .withoutEscapingSlashes
        ]
        return encoder
    }()
}
