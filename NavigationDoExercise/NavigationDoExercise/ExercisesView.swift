import SwiftUI

struct ExercisesView: View {
	@Bindable var model: ExercisesModel
	
	var body: some View {
		List {
			ForEach(model.exercises) { exercise in
				ExerciseRowView(exercise: exercise)
					.swipeActions(edge: .trailing) {
						Button {
							model.onDeleteButtonTapped(exercise)
						} label: {
							Label("Trash", systemImage: "trash")
						}
						.tint(.red)
					}
					.swipeActions(edge: .leading) {
						Button {
							model.dialogButtonTapped(exercise)
						} label: {
							Label("Flag", systemImage: "flag")
						}
						.tint(.green)
					}
			}
		}
		.listRowSpacing(8)
		.alert(
			"Delete exercise",
			isPresented: $model.alertIsPresented,
			presenting: model.exerciseToRemove
		) { exercise in
			Button("Remove", role: .destructive) {
				withAnimation {
					model.confirmDeleteButtonTapped()
				}
			}
		} message: { exercise in
			Text("Are you sure that you want to remove this exercise? Total distance \(exercise.distanceFormatted).")
		}
		.confirmationDialog(
			"Change exercise type",
			isPresented: $model.dialogIsPresented,
			titleVisibility: .visible
		) {
			Button("Cycling") {
				withAnimation { model.confirmDialogButtonTapped(type: .cycling) }
			}
			Button("Swimming") {
				withAnimation { model.confirmDialogButtonTapped(type: .swimming) }
			}
			Button("Running") {
				withAnimation { model.confirmDialogButtonTapped(type: .running) }
			}
			Button("Walking") {
				withAnimation { model.confirmDialogButtonTapped(type: .walking) }
			}
		} message: {
			Text("Choose a new option for the exercise type.")
		}
	}
}

#Preview {
	ExercisesView(
		model: ExercisesModel(
			exercises: (0..<50).map { _ in
				Exercise.fake(.random)
			}
		)
	)
}
