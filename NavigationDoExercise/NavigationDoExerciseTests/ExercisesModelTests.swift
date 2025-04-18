import Testing
@testable import NavigationDoExercise

struct NavigationDoExercisesListTests {
	@Test func givenExercisesWhenOnAlertSwipeCalledThenAlertShownAndExercisesDeleted() async throws {
		let exercise = Exercise.fake(.random)
		
		let model = ExercisesModel(
			exercises: [
				exercise
			]
		)
		
		model.alertButtonTapped(exercise)
		model.confirmAlertButtonTapped()
		
		#expect(model.exercises.isEmpty)
	}
	
	@Test func givenExercisesWhenOnDialogSwipeCalledThenDialogShownAndExerciseChangedToRunning() async throws {
		let exercise = Exercise.fake(type: .cycling)
		
		let model = ExercisesModel(
			exercises: [
				exercise
			]
		)
		
		model.dialogButtonTapped(exercise)
		model.confirmDialogButtonTapped(type: .running)
		
		#expect(model.exercises[0].type == .running)
	}
}
