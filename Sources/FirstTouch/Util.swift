import Foundation

enum DateUtil {
    static func dayID(for date: Date, timeZone: TimeZone = .current) -> String {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = timeZone
        let c = cal.dateComponents([.year, .month, .day], from: date)

        let y = String(format: "%04d", c.year ?? 0)
        let m = String(format: "%02d", c.month ?? 0)
        let d = String(format: "%02d", c.day ?? 0)
        return "\(y)-\(m)-\(d)"
    }

    static func iso8601(_ date: Date) -> String {
        ISO8601DateFormatter().string(from: date)
    }

    static func prettyDate(from dayID: String) -> String {
        let parts = dayID.split(separator: "-")
        guard parts.count == 3,
              let y = Int(parts[0]),
              let m = Int(parts[1]),
              let d = Int(parts[2]) else { return dayID }

        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = .current
        var comps = DateComponents()
        comps.year = y; comps.month = m; comps.day = d
        guard let date = cal.date(from: comps) else { return dayID }

        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        return f.string(from: date)
    }

    static func prettyTime(from iso: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: iso) else { return iso }
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .short
        return f.string(from: date)
    }
}
