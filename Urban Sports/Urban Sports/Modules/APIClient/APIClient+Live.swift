import Foundation

extension APIClient {
  public static var live: APIClient {
    APIClient(api: API(baseAPI: BaseAPI()))
  }
}
