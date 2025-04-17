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
}
