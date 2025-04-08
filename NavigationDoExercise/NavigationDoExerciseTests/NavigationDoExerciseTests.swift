import Testing
@testable import NavigationDoExercise

struct NavigationDoExerciseTests {
    @Test func givenSettingsTabSelectedWhenTapToExercisesThenExercisesTabSelected() async throws {
			let model = ContentModel(
				selectedTab: 1
			)
			
			model.exercisesButtonTapped()
			
			#expect(model.selectedTab == 0)
    }
}
