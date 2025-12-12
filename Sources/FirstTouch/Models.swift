import Foundation

struct DayCard: Codable, Identifiable, Equatable {
    // "YYYY-MM-DD" (local timezone)
    let id: String
    // ISO8601 datetime string of first open
    let firstTouchISO8601: String
}
