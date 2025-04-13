import Foundation
import Observation

@Observable
class ExercisesModel {
	var exercises: [Exercise]
	
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
