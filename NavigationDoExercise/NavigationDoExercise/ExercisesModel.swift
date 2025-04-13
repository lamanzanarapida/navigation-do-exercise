import Observation

@Observable
class ExercisesModel {
	let exercises: [Exercise]
	
	init(
		exercises: [Exercise] = []
	) {
		self.exercises = exercises
	}
}
