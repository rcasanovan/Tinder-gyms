import Foundation

extension BaseAPI {
  private enum Constants {
    static let scheme = "https"
    static let baseUrl = "data.townofcary.org"
    static let path = "/api/explore/v2.1/catalog/datasets/open-gym/records"

    enum Parameters {
      static let limit = "limit"
    }
  }

  func getGymsURL(limit: Int) -> URL? {
    var components = URLComponents()
    components.scheme = Constants.scheme
    components.host = Constants.baseUrl
    components.path = Constants.path
    components.queryItems = [
      URLQueryItem(name: Constants.Parameters.limit, value: String(limit))
    ]
    return components.url
  }
}
