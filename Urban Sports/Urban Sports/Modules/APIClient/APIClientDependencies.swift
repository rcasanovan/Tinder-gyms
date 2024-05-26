import Dependencies
import Foundation

// Dependencies for the API client
public enum APIClientDependencyKey: DependencyKey {
  /// For the live state, return a real APIClient
  public static let liveValue: APIClientProtocol = APIClient.live
}

#if DEBUG
extension APIClientDependencyKey: TestDependencyKey {
  /// For the preview / test state, return a mock APIClient
  public static let previewValue: APIClientProtocol = APIClient.mock
  public static let testValue: APIClientProtocol = APIClient.mock
}
#endif

extension DependencyValues {
  /// The current APIClient
  public var apiClient: APIClientProtocol {
    get { self[APIClientDependencyKey.self] }
    set { self[APIClientDependencyKey.self] = newValue }
  }
}
