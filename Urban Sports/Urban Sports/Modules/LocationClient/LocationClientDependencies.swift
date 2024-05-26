import Dependencies
import Foundation

// Dependencies for the location client
public enum LocationClientDependencyKey: DependencyKey {
  /// For the live state, return a real LocationClient
  public static let liveValue: LocationClientProtocol = LocationClient.live
}

#if DEBUG
extension LocationClientDependencyKey: TestDependencyKey {
  /// For the preview / test state, return a mock LocationClient
  public static let previewValue: LocationClientProtocol = LocationClientMock.mock
  public static let testValue: LocationClientProtocol = LocationClientMock.mock
}
#endif

extension DependencyValues {
  public var locationClient: LocationClientProtocol {
    get { self[LocationClientDependencyKey.self] }
    set { self[LocationClientDependencyKey.self] = newValue }
  }
}
