import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: FirstTouchStore
    @State private var showDanger = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("First Touch")
                            .font(.title).bold()
                        Text("This records the first time you open the app each day. One card. No charts.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 6)
                }

                if store.cards.isEmpty {
                    Section {
                        Text("Open the app in the morning. The first open of the day becomes your card.")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Section("Days") {
                        ForEach(store.cards) { card in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(DateUtil.prettyDate(from: card.id))
                                    .font(.headline)
                                Text("First touch: \(DateUtil.prettyTime(from: card.firstTouchISO8601))")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }

                Section {
                    Button(role: .destructive) { showDanger = true } label: {
                        Text("Delete all cards")
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete everything?", isPresented: $showDanger) {
                Button("Delete", role: .destructive) { store.deleteAll() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This cannot be undone.")
            }
        }
    }
}
