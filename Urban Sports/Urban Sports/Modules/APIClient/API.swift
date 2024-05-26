import Foundation

protocol APIProtocol {
  func getGyms(limit: Int) async -> Result<[GymAPIDataModel], APIError>
}

class API: APIProtocol {
  let baseAPI: BaseAPI

  init(baseAPI: BaseAPI) {
    self.baseAPI = baseAPI
  }

  func getGyms(limit: Int) async -> Result<[GymAPIDataModel], APIError> {
    await baseAPI.sendRequest(url: baseAPI.getGymsURL(limit: limit), responseModel: GymsAPIDataModel.self)
      .map { $0.results }
  }
}
