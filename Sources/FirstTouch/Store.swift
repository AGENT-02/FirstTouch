import Foundation
import SwiftUI

@MainActor
final class FirstTouchStore: ObservableObject {
    @Published private(set) var cards: [DayCard] = []

    private let filename = "firsttouch_cards.json"

    init() {
        load()
    }

    func recordFirstTouchIfNeeded(now: Date = Date()) async {
        let today = DateUtil.dayID(for: now)

        if cards.contains(where: { $0.id == today }) {
            return
        }

        let new = DayCard(id: today, firstTouchISO8601: DateUtil.iso8601(now))
        cards.insert(new, at: 0)
        persist()
    }

    func deleteAll() {
        cards = []
        persist()
    }

    // MARK: - Persistence

    private func docsURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    private func fileURL() -> URL {
        docsURL().appendingPathComponent(filename)
    }

    private func load() {
        let url = fileURL()
        guard let data = try? Data(contentsOf: url) else { return }
        if let decoded = try? JSONDecoder().decode([DayCard].self, from: data) {
            cards = decoded
        }
    }

    private func persist() {
        let url = fileURL()
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            // silent by design
        }
    }
}
