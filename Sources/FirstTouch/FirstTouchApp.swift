import SwiftUI

@main
struct FirstTouchApp: App {
    @StateObject private var store = FirstTouchStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .task {
                    await store.recordFirstTouchIfNeeded()
                }
        }
    }
}
