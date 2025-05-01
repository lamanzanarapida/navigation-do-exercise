import SwiftUI

@main
struct NavigationDoExerciseApp: App {
	var body: some Scene {
		WindowGroup {
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
	}
}
