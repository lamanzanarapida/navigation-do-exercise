import Testing
@testable import NavigationDoExercise

struct NavigationDoExercisesListTests {
		@Test func givenExercisesWhenOnDeleteExercisesCalledThenExercisesDeleted() async throws {
			let model = ExercisesModel(
				exercises: [
					.fake(.random)
				]
			)
			
			model.onDeleteExercises([0])
			
			#expect(model.exercises.isEmpty)
		}
}
