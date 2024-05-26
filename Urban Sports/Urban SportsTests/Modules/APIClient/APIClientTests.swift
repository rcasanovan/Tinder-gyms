import XCTest

@testable import Urban_Sports

final class APIClientTests: XCTestCase {
  func testAPIClientGetGymsSuccess() async {
    // Given
    let apiClient = APIClient.mock

    // When
    let result = await apiClient.getGyms()

    // Then
    switch result {
    case .success(let gyms):
      XCTAssertFalse(gyms.isEmpty, "Gyms list should not be empty")
    case .failure(let error):
      XCTFail("Expected success, but got failure with error: \(error)")
    }
  }

  func testAPIClientGetGymsFailure() async {
    // Given
    let apiClient = APIClient.failureMock

    // When
    let result = await apiClient.getGyms()

    // Then
    switch result {
    case .success:
      XCTFail("Expected failure, but got success")
    case .failure(let error):
      XCTAssertEqual(error, .serverError(code: 999), "Expected server error with specific code")
    }
  }
}
