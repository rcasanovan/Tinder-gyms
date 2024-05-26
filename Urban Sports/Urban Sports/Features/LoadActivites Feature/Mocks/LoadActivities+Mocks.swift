import ComposableArchitecture
import Foundation

#if DEBUG

extension LoadActivites.State {
  static let loading = Self(networkState: .loading)

  static let success = Self(networkState: .completed(.success(.mock)))

  static let failure = Self(networkState: .completed(.failure(.cannotLoadGyms(error: "error"))))
}

extension LoadActivites.Gym {
  static let mock = Self(
    id: "_id_0_",
    startDate: Date(timeIntervalSince1970: 1_703_152_800),
    endDate: Date(timeIntervalSince1970: 1_703_161_800),
    timeZone: ISO8601DateFormatter().timeZone,
    facilityTitle: "Bond Park Community Center",
    location: "Sycamore Gymnasium",
    address: "150 Metro Park",
    provinceCode: "NC",
    postalCode: "27513",
    activity: "Basketball",
    imagePath: "test_image_0"
  )
}

extension Array where Element == LoadActivites.Gym {
  static let mock = Self([
    .init(
      id: "_id_0_",
      startDate: Date(timeIntervalSince1970: 1_703_152_800),
      endDate: Date(timeIntervalSince1970: 1_703_161_800),
      timeZone: ISO8601DateFormatter().timeZone,
      facilityTitle: "Bond Park Community Center",
      location: "Sycamore Gymnasium",
      address: "150 Metro Park",
      provinceCode: "NC",
      postalCode: "27513",
      activity: "Basketball",
      imagePath: "test_image_0"
    ),
    .init(
      id: "_id_1_",
      startDate: Date(timeIntervalSince1970: 1_703_152_800),
      endDate: Date(timeIntervalSince1970: 1_703_161_800),
      timeZone: ISO8601DateFormatter().timeZone,
      facilityTitle: "Herbert C. Young Community Center",
      location: "Coach Kay Yow Court",
      address: "101 Wilkinson AVE",
      provinceCode: "NC",
      postalCode: "27513",
      activity: "Open Gym",
      imagePath: "test_image_1"
    ),
    .init(
      id: "_id_2_",
      startDate: Date(timeIntervalSince1970: 1_703_152_800),
      endDate: Date(timeIntervalSince1970: 1_703_161_800),
      timeZone: ISO8601DateFormatter().timeZone,
      facilityTitle: "Middle Creek Community Center",
      location: "South Gym",
      address: "123 Middle Creek Park AVE",
      provinceCode: "NC",
      postalCode: "27539",
      activity: "Basketball",
      imagePath: "test_image_2"
    ),
  ]
  )
}

#endif
