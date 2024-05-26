import Foundation

#if DEBUG

class APIMock: APIProtocol {
  func getGyms(limit: Int) async -> Result<[GymAPIDataModel], APIError> {
    return .success(.mock)
  }
}

class APIErrorMock: APIProtocol {
  func getGyms(limit: Int) async -> Result<[GymAPIDataModel], APIError> {
    return .failure(.serverError(code: 999))
  }
}

extension APIClient {
  static let mock = APIClient(api: APIMock())
  static let failureMock = APIClient(api: APIErrorMock())
}

#endif
