import Foundation
import Observation

@Observable
class ExercisesModel {
	var alertIsPresented: Bool = true
	var exercises: [Exercise]
	var exerciseToRemove: Exercise?
	
	init(
		exercises: [Exercise] = []
	) {
		self.exercises = exercises
	}
	
	func onDeleteExercises(_ indexSet: IndexSet) {
		for index in indexSet {
			exercises.remove(at: index)
		}
	}
}
