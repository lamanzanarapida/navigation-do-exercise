import SwiftUI

enum Tab {
	case exercises, settings
}

@Observable
final class ContentModel {
	var selectedTab: Tab
	
	init(
		selectedTab: Tab = .exercises
	) {
		self.selectedTab = selectedTab
	}
	
	func exercisesButtonTapped() {
		selectedTab = .exercises
	}
}

struct ContentView: View {
	@Bindable var model: ContentModel
	
	var body: some View {
		TabView(selection: $model.selectedTab) {
			SwiftUI.Tab("Exercises", systemImage: "figure.run", value: Tab.exercises) {
				Text("Exercises")
			}
			SwiftUI.Tab("Settings", systemImage: "gear", value: Tab.settings) {
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
			selectedTab: .settings
		)
	)
}
