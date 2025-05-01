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
	
	@Test func givenExercisesWhenAddButtonTappedNewExerciseAdded() async throws {
		let model = ExercisesModel()
		
		model.addExerciseButtonTapped()
		
		#expect(model.destination?.exerciseToAdd!.exerciseButtonDisabled == true)
		
		model.destination!.exerciseToAdd!.exercise.title = "New exercise"
		model.destination!.exerciseToAdd!.exercise.distance = 1.5
		
		#expect(model.destination!.exerciseToAdd!.exerciseButtonDisabled == false)
		
		model.confirmAddButtonTapped(exercise: model.destination!.exerciseToAdd!.exercise)
		
		#expect(model.exercises.count == 1)
	}
	
	@Test func givenExercisesWhenEditButtonTappedExerciseIsEdited() async throws {
		let exercise = Exercise.fake(type: .cycling)
		
		let model = ExercisesModel(
			exercises: [
				exercise
			]
		)
		
		model.editButtonTapped(exercise)
		model.destination!.exerciseToEdit!.exercise.title = "Edited exercise"
		model.confirmEditButtonTapped(exercise: model.destination!.exerciseToEdit!.exercise)
		
		#expect(model.exercises[0].title == "Edited exercise")
	}
}
