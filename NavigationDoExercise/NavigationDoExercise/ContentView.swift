import SwiftUI

@Observable
final class ContentModel {
	var selectedTab: Int
	
	init(
		selectedTab: Int = 0
	) {
		self.selectedTab = selectedTab
	}
	
	func exercisesButtonTapped() {
		selectedTab = 0
	}
}

struct ContentView: View {
	@Bindable var model: ContentModel
	
	var body: some View {
		TabView(selection: $model.selectedTab) {
			Tab("Exercises", systemImage: "figure.run", value: 0) {
				Text("Exercises")
			}
			Tab("Settings", systemImage: "gear", value: 1) {
				Button("Tap to exercises") {
					model.exercisesButtonTapped()
				}
			}
		}
	}
}

#Preview("Exercises") {
	ContentView(
		model: ContentModel()
	)
}

#Preview("Settings") {
	ContentView(
		model: ContentModel(
			selectedTab: 1
		)
	)
}
