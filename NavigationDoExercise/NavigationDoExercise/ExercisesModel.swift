import Foundation
import Observation

@Observable
class ExercisesModel {
	var destination: Destination?
	var exercises: [Exercise]
	
	enum Destination {
		case alert(Exercise)
		case dialog(Exercise)
	}
	
	init(
		destination: Destination? = nil,
		exercises: [Exercise] = []
	) {
		self.destination = destination
		self.exercises = exercises
	}
	
	func alertButtonTapped(_ exercise: Exercise) {
		destination = .alert(exercise)
	}
	
	func confirmAlertButtonTapped() {
		guard
			case let .alert(exercise) = destination,
			let index = exercises.firstIndex(where: { exercise.id == $0.id })
		else { return }
		exercises.remove(at: index)
		destination = nil
	}
	
	func confirmDialogButtonTapped(type: Exercise.Mode) {
		guard
			case let .dialog(exercise) = destination,
			let index = exercises.firstIndex(where: { exercise.id == $0.id })
		else { return }
		exercises[index].type = type
		destination = nil
	}
	
	func dialogButtonTapped(_ exercise: Exercise) {
		destination = .dialog(exercise)
	}
	
	func dismissButtonTapped() {
		destination = nil
	}
}

extension ExercisesModel.Destination {
	var exerciseToRemove: Exercise? {
		guard case let .alert(exercise) = self else {
			return nil
		}
		return exercise
	}
}
