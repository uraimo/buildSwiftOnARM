import XCTest
import Foundation

class FoundationTests: XCTestCase {

    func testSuccess() {
        XCTAssertTrue(true)
    }

    func testContentsOfFile() {
        if let str = try? String(contentsOfFile: "Tests/inputs/testfile") {
            XCTAssertEqual(str.trimmingCharacters(in: .whitespacesAndNewlines), "content")
        } else {
            XCTFail("Unable to read string from input file")
        }
    }

    func testWriteToFile() {
        do {
            try "Some content".write(toFile:"Tests/outputs/testfile", atomically: false, encoding: .utf8)
        } catch {
            XCTFail("Unable to write string to file")
        }
        if let str = try? String(contentsOfFile: "Tests/outputs/testfile") {
            XCTAssertEqual(str.trimmingCharacters(in: .whitespacesAndNewlines), "Some content")
        } else {
            XCTFail("Unable to read string from output file")
        }
    }

    func testURL() {
        class MakeAURL {
            func makeURL() {
                _ = URL(string: "http://www.google.com")
            }
        }

        _ = URL(string: "http://www.google.com")

        let makeAURL = MakeAURL()
        makeAURL.makeURL()
        XCTAssertTrue(true)
    }

    func testContentsOfURL() {
        do {
            _ = try String(contentsOf: URL(string: "https://httpbin.org/get")!, encoding: .utf8)
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testProcess() {
        let p = Process()
            p.launchPath = "/usr/bin/tail"
            p.arguments = ["-f", "/var/log/system.log"]
            p.launch()

            var elapsedSeconds = 10
            while p.isRunning && elapsedSeconds > 0 {
                print("Running")
                sleep(1)
                elapsedSeconds -= 1
            }

        XCTAssertTrue(true)
    }

    func testIfLinux() {
    #if os(Linux)
        XCTAssertTrue(true)
    #else
        XCTFail()
    #endif
    }

    static var allTests = [
        ("testSuccess", testSuccess),
        ("testContentsOfFile", testContentsOfFile),
        ("testWriteToFile", testWriteToFile),
        ("testURL", testURL),
        ("testContentsOfURL", testContentsOfURL),
        ("testProcess", testProcess),
        ("testIfLinux", testIfLinux)
    ]
}
