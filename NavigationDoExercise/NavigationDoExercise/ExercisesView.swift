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
			}
		}
		.listRowSpacing(8)
		.alert(
			"Delete exercise",
			isPresented: $model.alertIsPresented,
			presenting: model.exerciseToRemove
		) { exercise in
			Button("Remove", role: .destructive) {}
		} message: { exercise in
			Text("Are you sure that you want to remove this exercise? Total distance \(exercise.distanceFormatted).")
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
