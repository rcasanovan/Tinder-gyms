import Foundation

public struct GymsAPIDataModel: Decodable {
  public let total_count: UInt
  public let results: [GymAPIDataModel]
}

public struct GymAPIDataModel: Decodable {
  public let open_gym_start: String
  public let open_gym_end: String
  public let facility_title: String
  public let location: String
  public let address11: String
  public let province_code1: String
  public let postal_code1: String
  public let pass_type: String
  public let community_center: String
  public let open_gym: String
  public let group: String?
}
