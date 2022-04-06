import XCTest
import ResponseParser
import Hated

final class HatedTests: XCTestCase {

    func test_encode() throws {
        let account = Account(number: "12345", balance: Money(amount: 150.00, currency: "USD"))
        let links = Account.Links(account: account)

        let hated = Hated<Account, Account.Links>(object: account, links: links)
        let sut = try JSONEncoder.default.encode(hated)

        XCTAssertEqual(String(data: sut, encoding: .utf8), .account)
    }

    func test_decode() throws {
        let json = String.account

        let sut = try JSONDecoder.default.decode(Hated<Account, Account.Links>.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(sut.object.number, "12345")
        XCTAssertEqual(sut.object.balance.amount, 150)
        XCTAssertEqual(sut.object.balance.currency, "USD")

        XCTAssertEqual(sut.links.deposit, "/account/12345/deposit")
        XCTAssertEqual(sut.links.withdraw, "/account/12345/withdraw")
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
            deposit = "/account/\(account.number)/deposit"
            withdraw = "/account/\(account.number)/withdraw"
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
