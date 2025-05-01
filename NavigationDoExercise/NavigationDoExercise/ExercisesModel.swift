import Foundation
import Observation

@Observable
class ExercisesModel {
	var destination: Destination?
	var exercises: [Exercise]
	
	enum Destination: Equatable {
		case add(ExerciseModel)
		case alert(Exercise)
		case dialog(Exercise)
		case edit(ExerciseModel)
	}
	
	init(
		destination: Destination? = nil,
		exercises: [Exercise] = []
	) {
		self.destination = destination
		self.exercises = exercises
	}
	
	func addExerciseButtonTapped() {
			destination = .add(ExerciseModel())
	}
	
	func alertButtonTapped(_ exercise: Exercise) {
		destination = .alert(exercise)
	}
	
	func confirmAddButtonTapped(exercise: Exercise) {
		exercises.append(exercise)
		destination = nil
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
	
	func confirmEditButtonTapped(exercise: Exercise) {
		guard
			let index = exercises.firstIndex(where: { $0.id == exercise.id })
		else { return }
		exercises[index] = exercise
		destination = nil
	}
	
	func dialogButtonTapped(_ exercise: Exercise) {
		destination = .dialog(exercise)
	}
	
	func dismissButtonTapped() {
		destination = nil
	}
	
	func editButtonTapped(_ exercise: Exercise) {
		destination = .edit(ExerciseModel(exercise: exercise))
	}
}

extension ExercisesModel.Destination {
	var exerciseToAdd: ExerciseModel? {
		guard case let .add(model) = self else {
			return nil
		}
		return model
	}
	var exerciseToEdit: ExerciseModel? {
		guard case let .edit(model) = self else {
			return nil
		}
		return model
	}
	var exerciseToRemove: Exercise? {
		guard case let .alert(exercise) = self else {
			return nil
		}
		return exercise
	}
	var exerciseToUpdate: Exercise? {
		guard case let .dialog(exercise) = self else {
			return nil
		}
		return exercise
	}
}
