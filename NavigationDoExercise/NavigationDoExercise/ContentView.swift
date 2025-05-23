import SwiftUI

enum Tab {
	case exercises, settings
}

@Observable
final class ContentModel {
	var exercisesModel: ExercisesModel
	var selectedTab: Tab
	
	init(
		exercisesModel: ExercisesModel = ExercisesModel(),
		selectedTab: Tab = .exercises
	) {
		self.exercisesModel = exercisesModel
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
				NavigationStack {
					ExercisesView(
						model: model.exercisesModel
					)
					.navigationTitle("Exercises")
				}
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
		model: ContentModel(
			exercisesModel: ExercisesModel(
				exercises: (0..<5).map { _ in
					Exercise.fake(.random)
				}
			)
		)
	)
}

#Preview("Settings") {
	ContentView(
		model: ContentModel(
			selectedTab: .settings
		)
	)
}
