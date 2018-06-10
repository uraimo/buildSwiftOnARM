import XCTest
import Foundation
import Dispatch

class DispatchTests: XCTestCase {

    func testDataTaskSemaphore(){
	var urlRequest = URLRequest(url: URL(string:"https://httpbin.org/get")!)
	urlRequest.httpMethod = "GET"
	let config = URLSessionConfiguration.default
	let session = URLSession(configuration: config)

	let semaphore = DispatchSemaphore(value: 0)
	let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in    
	    let _ = String(data:data!, encoding:.utf8)
	    semaphore.signal()
	})
	task.resume()

	_ = semaphore.wait(timeout: .distantFuture)
	XCTAssertTrue(true)
    }

    static var allTests = [
	("testDataTaskSemaphore", testDataTaskSemaphore),
    ]

}



