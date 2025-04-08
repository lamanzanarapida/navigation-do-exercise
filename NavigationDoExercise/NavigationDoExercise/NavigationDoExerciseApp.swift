import SwiftUI

@main
struct NavigationDoExerciseApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView(
				model: ContentModel()
			)
		}
	}
}
