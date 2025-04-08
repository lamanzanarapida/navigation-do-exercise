import SwiftUI

struct ContentView: View {
	@State var selectedTab = 0
	
	var body: some View {
		TabView(selection: $selectedTab) {
			Tab("Exercises", systemImage: "figure.run", value: 0) {
				Text("Exercises")
			}
			Tab("Settings", systemImage: "gear", value: 1) {
				Button("Tap to exercises") {
					selectedTab = 0
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
