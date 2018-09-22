import XCTest
@testable import buildSwiftOnARMTests

XCTMain([
    testCase(FoundationTests.allTests),
    testCase(DispatchTests.allTests),
    testCase(SwiftyJsonTests.allTests)
])


