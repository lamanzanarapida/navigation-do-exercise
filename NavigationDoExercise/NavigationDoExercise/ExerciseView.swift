import SwiftUI

@Observable
class ExerciseModel {
	var exercise: Exercise
	
	init(
		exercise: Exercise = .empty
	) {
		self.exercise = exercise
	}
	
	var addExerciseButtonDisabled: Bool {
		exercise.title.isEmpty
		|| exercise.distance == 0
	}
}

extension ExerciseModel: Equatable {
	static func == (lhs: ExerciseModel, rhs: ExerciseModel) -> Bool {
		lhs.exercise == rhs.exercise
	}
}

extension ExerciseModel: Identifiable {
	var id: Exercise.ID {
		exercise.id
	}
}

struct ExerciseView: View {
	@Bindable var model: ExerciseModel
	
	var body: some View {
		VStack {
			Form {
				Section("Write a title") {
					TextField("The title", text: $model.exercise.title)
				}
				.textCase(nil)
				Section("Select the type") {
					Picker("Selected Type", selection: $model.exercise.type) {
						ForEach(Exercise.Mode.allCases, id: \.self) { type in
							Text(type.rawValue.capitalized).tag(type)
						}
					}
					.pickerStyle(.navigationLink)
				}
				.textCase(nil)
				Section("Set the distance") {
					TextField("Distance", value: $model.exercise.distance, format: .number)
				}
				.textCase(nil)
				Section("Set starting and finishing dates") {
					DatePicker("Started", selection: $model.exercise.starts)
					if model.exercise.isFinished {
						DatePicker(
							"Finished",
							selection: Binding(
								get: { model.exercise.finished ?? Date() },
								set: { model.exercise.finished = $0 }
							)
						)
						Button("Not finish the exercise?") {
							model.exercise.finished = nil
						}
					} else {
						Button("Finish the exercise?") {
							model.exercise.finished = Date()
						}
					}
				}
				.textCase(nil)
			}
		}
	}
}

#Preview {
	NavigationStack {
		ExerciseView(
			model: ExerciseModel(
				exercise: .empty
			)
		)
		.navigationTitle("Doing exercise!")
	}
}
