import SwiftUI

struct ExercisesView: View {
	@Bindable var model: ExercisesModel
	
	var body: some View {
		List {
			ForEach(model.exercises.sorted(by: { $0.starts > $1.starts })) { exercise in
				ExerciseRowView(exercise: exercise)
					.swipeActions(edge: .trailing) {
						Button {
							model.alertButtonTapped(exercise)
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
			isPresented: Binding(
				get: {
					if case .alert = model.destination {
						return true
					}
					return false
				}, set: { isPresented in
					if !isPresented {
						model.dismissButtonTapped()
					}
				}
			),
			presenting: model.destination?.exerciseToRemove
		) { exercise in
			Button("Remove", role: .destructive) {
				withAnimation {
					model.confirmAlertButtonTapped()
				}
			}
		} message: { exercise in
			Text("Are you sure that you want to remove this exercise? Total distance \(exercise.distanceFormatted).")
		}
		.confirmationDialog(
			"Change exercise type",
			isPresented: Binding(
				get: {
					if case .dialog = model.destination {
						return true
					}
					return false
				}, set: { isPresented in
					model.dismissButtonTapped()
				}
			),
			titleVisibility: .visible
		) {
			ForEach(
				Exercise.Mode.allCases,
				id: \.self
			) { type in
				Button(type.rawValue.capitalized) {
					withAnimation { model.confirmDialogButtonTapped(type: type) }
				}
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
