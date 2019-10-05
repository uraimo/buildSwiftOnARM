import XCTest
import Foundation
import FoundationNetworking
import Dispatch

class DispatchTests: XCTestCase {

    func testDataTaskSemaphore(){
        var urlRequest = URLRequest(url: URL(string:"https://httpbin.org/get")!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in    
            let _ = String(data:data ?? "<empty>".data(using: String.Encoding.utf8)!, encoding:.utf8)
            semaphore.signal()
        })
        task.resume()

        _ = semaphore.wait(timeout: .distantFuture)
        XCTAssertTrue(true)
    }

    func testDispatchTimeInterval(){
	let now = DispatchTime.now()
	let nowplustwo = now + .nanoseconds(2)
	let nowut = now.uptimeNanoseconds 

	XCTAssertEqual(nowplustwo.uptimeNanoseconds, nowut+2)
        XCTAssertNotEqual("DispatchTime(unknown: ())","\(nowplustwo)")

        XCTAssertEqual("nanoseconds(1)","\(DispatchTimeInterval.nanoseconds(1))")
    }

    static var allTests = [
        ("testDataTaskSemaphore", testDataTaskSemaphore),
        ("testDispatchTimeInterval", testDispatchTimeInterval),
    ]

}



