import Foundation
import Observation

@Observable
class ExercisesModel {
	var alertIsPresented = false
	var dialogIsPresented = false
	var exercises: [Exercise]
	var exerciseToRemove: Exercise?
	var exerciseToUpdate: Exercise?
	
	init(
		exercises: [Exercise] = []
	) {
		self.exercises = exercises
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
	
	func confirmDialogButtonTapped(type: Exercise.Mode) {
		guard
			let exercise = exerciseToUpdate,
			let index = exercises.firstIndex(where: { exercise.id == $0.id })
		else { return }
		exercises[index].type = type
		dialogIsPresented = false
		exerciseToUpdate = nil
	}
	
	func dialogButtonTapped(_ exercise: Exercise) {
		dialogIsPresented = true
		exerciseToUpdate = exercise
	}
	
	func onDeleteButtonTapped(_ exercise: Exercise) {
		alertIsPresented = true
		exerciseToRemove = exercise
	}
}
