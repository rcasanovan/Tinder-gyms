import Foundation

public class BaseAPI {
  func sendRequest<T: Decodable>(url: URL?, responseModel: T.Type) async -> Result<T, APIError> {
    guard let url = url else {
      return .failure(.wrongRequest)
    }

    do {
      let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url), delegate: nil)
      guard let response = response as? HTTPURLResponse else {
        return .failure(.notResults)
      }
      switch response.statusCode {
      case 200...299:
        guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
          return .failure(.parsingError)
        }
        return .success(decodedResponse)
      case 401:
        return .failure(.unauthorized)
      default:
        return .failure(.serverError(code: response.statusCode))
      }
    } catch {
      return .failure(.unknown)
    }
  }
}
