import CoreLocation
import Foundation

#if DEBUG

public class LocationClientMock: LocationClientProtocol {
  public func distanceTo(placeName: String, address: String, provinceCode: String, postalCode: String) async
    -> CLLocationDistance?
  {
    let distance: CLLocationDistance = 1000.0
    return distance
  }
}

extension LocationClientMock {
  public static var mock: LocationClientMock {
    LocationClientMock()
  }
}

#endif
