//
//  MockSession.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 01/06/2022.
//

import Foundation
class MockSessionApi {
     func loadJsonData(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }

     func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {

        let data = loadJsonData(file: file)
        let response = HTTPURLResponse(url: URL(string: "https://saurav.tech/NewsAPI/everything/cnn.json")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
