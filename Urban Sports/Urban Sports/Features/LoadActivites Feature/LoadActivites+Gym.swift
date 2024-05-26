import Foundation

extension LoadActivites {
  public struct Gym: Identifiable, Equatable {
    public var id: String
    var startDate: Date?
    var endDate: Date?
    var timeZone: TimeZone?
    var facilityTitle: String
    var location: String
    var address: String
    var provinceCode: String
    var postalCode: String
    var activity: String
    var imagePath: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
  }
}

extension LoadActivites.Gym {
  init(gymAPIDataModel: GymAPIDataModel) {
    let combinedID =
      "\(gymAPIDataModel.open_gym_start)\(gymAPIDataModel.open_gym_end)\(gymAPIDataModel.facility_title)\(gymAPIDataModel.location)\(gymAPIDataModel.address11)\(gymAPIDataModel.province_code1)\(gymAPIDataModel.postal_code1)"

    // Hash the combined string to produce a unique identifier
    let hashID = combinedID.hash

    self.id = String(hashID)
    let formatter = ISO8601DateFormatter()
    self.startDate = formatter.date(from: gymAPIDataModel.open_gym_start)
    self.endDate = formatter.date(from: gymAPIDataModel.open_gym_end)
    self.timeZone = formatter.timeZone
    self.facilityTitle = gymAPIDataModel.facility_title
    self.location = gymAPIDataModel.location
    self.address = gymAPIDataModel.address11
    self.provinceCode = gymAPIDataModel.province_code1
    self.postalCode = gymAPIDataModel.postal_code1
    self.activity = gymAPIDataModel.open_gym
    self.imagePath = "test_image_2"
  }
}
