import Foundation

public protocol APIClientProtocol {
  func getGyms() async -> Result<[GymAPIDataModel], APIError>
}

public class APIClient: APIClientProtocol {
  private let api: APIProtocol

  init(api: APIProtocol) {
    self.api = api
  }

  public func getGyms() async -> Result<[GymAPIDataModel], APIError> {
    await api.getGyms(limit: 100)
  }
}
