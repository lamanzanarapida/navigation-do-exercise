import Foundation
import Observation

@Observable
class ExercisesModel {
	var alertIsPresented = false
	var exercises: [Exercise]
	var exerciseToRemove: Exercise?
	
	init(
		exercises: [Exercise] = []
	) {
		self.exercises = exercises
	}
	
	func onDeleteButtonTapped(_ exercise: Exercise) {
		alertIsPresented = true
		exerciseToRemove = exercise
	}
	
	func confirmDeleteButtonTapped() {
		guard
			let exercise = exerciseToRemove,
			let index = exercises.firstIndex(where: { exercise.id == $0.id })
		else { return }
		exercises.remove(at: index)
		alertIsPresented = false
		exerciseToRemove = nil
	}
}
