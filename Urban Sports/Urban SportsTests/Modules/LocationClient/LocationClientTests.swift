import CoreLocation
import XCTest

@testable import Urban_Sports

class LocationClientTests: XCTestCase {
  func testLocationClientDistanceToSuccess() async {
    // Given
    let locationClient = LocationClient()
    let placeName = "Sycamore Gymnasium"
    let address = "150 Metro Park"
    let provinceCode = "NC"
    let postalCode = "27513"

    // When
    if let distance = await locationClient.distanceTo(
      placeName: placeName,
      address: address,
      provinceCode: provinceCode,
      postalCode: postalCode
    ) {
      // Then
      XCTAssertGreaterThan(distance, 0, "Distance should be greater than 0")
    } else {
      XCTFail("Distance calculation failed")
    }
  }

  func testLocationClientDistanceToFailure() async {
    // Given
    let locationClient = LocationClientMock.mock
    let placeName = "Sycamore Gymnasium"
    let address = "150 Metro Park"
    let provinceCode = "NC"
    let postalCode = "27513"

    // When
    let distance = await locationClient.distanceTo(
      placeName: placeName,
      address: address,
      provinceCode: provinceCode,
      postalCode: postalCode
    )

    // Then
    XCTAssertNotNil(distance, "Distance should not be nil")
    XCTAssertEqual(distance, 1000.0, "Distance should match mock value")
  }
}
