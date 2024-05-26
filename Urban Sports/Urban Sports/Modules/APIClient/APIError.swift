public enum APIError: Error, Equatable {
  case wrongRequest
  case parsingError
  case unauthorized
  case notResults
  case serverError(code: Int)
  case unknown
}
