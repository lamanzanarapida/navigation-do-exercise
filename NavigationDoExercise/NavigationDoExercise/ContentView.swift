import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			Tab("Exercises", systemImage: "figure.run") {
			}
			Tab("Settings", systemImage: "gear") {
			}
		}
	}
}

#Preview {
	ContentView()
}
