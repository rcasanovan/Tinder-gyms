import CoreLocation

public protocol LocationClientProtocol {
  func distanceTo(placeName: String, address: String, provinceCode: String, postalCode: String) async
    -> CLLocationDistance?
}

/// Encapsules the logic to get the distance to a place using the iOS GeoCoder.
public class LocationClient: LocationClientProtocol {
  /// The demo is mocking the user location. One improvement here is to request the real user location from the same LocationClient
  private var userLocation = CLLocation(latitude: 35.782169, longitude: -80.793457)

  /// Get the distance from the user location to a place
  ///
  /// If any error is returned, the function will return nil as a CLLocationDistance
  public func distanceTo(placeName: String, address: String, provinceCode: String, postalCode: String) async
    -> CLLocationDistance?
  {
    let geocoder = CLGeocoder()
    let addressString = "\(address), \(placeName), \(provinceCode) \(postalCode)"

    do {
      let placemarks = try await geocoder.geocodeAddressString(addressString)
      guard let placemark = placemarks.first else {
        print("No placemark found")
        return nil
      }

      let location = placemark.location!
      let distance = userLocation.distance(from: location)
      return distance
    } catch {
      print("Error geocoding address: \(error.localizedDescription)")
      return nil
    }
  }
}
