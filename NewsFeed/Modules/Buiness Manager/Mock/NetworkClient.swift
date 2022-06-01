import Foundation

class NetworkClient {

    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func showNewsFeed(url: URL, completion: @escaping  (_ newsFeedModel: NewsFeed?, _ errorMessage: String?) -> Void) {

        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }

            guard let data = data else {
                completion(nil, "No Data")
                return
            }

            switch statusCode {
            case 200:
                let newsFeedModel = try? JSONDecoder().decode(NewsFeed.self, from: data)
                completion(newsFeedModel, nil)
            case 404:
                completion(nil, "Bad Url")
            default:
                completion(nil, "statusCode: \(statusCode)")
            }
        }

        dataTask.resume()
    }
}
