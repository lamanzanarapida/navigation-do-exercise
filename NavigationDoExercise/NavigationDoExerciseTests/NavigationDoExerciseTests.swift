import Testing
@testable import NavigationDoExercise

struct NavigationDoExerciseTests {
    @Test func givenSettingsTabSelectedWhenTapToExercisesThenExercisesTabSelected() async throws {
			let model = ContentModel(
				selectedTab: .settings
			)
			
			model.exercisesButtonTapped()
			
			#expect(model.selectedTab == .exercises)
    }
}
