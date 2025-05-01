import SwiftUI

struct ExercisesView: View {
	@Bindable var model: ExercisesModel
	
	var body: some View {
		List {
			ForEach(model.exercises.sorted(by: { $0.starts > $1.starts })) { exercise in
				Button {
					model.editButtonTapped(exercise)
				} label: {
					ExerciseRowView(exercise: exercise)
						.contentShape(Rectangle())
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
				.buttonStyle(.plain)
			}
		}
		.listRowSpacing(8)
		.sheet(
			item: Binding(
				get: { model.destination?.exerciseToAdd },
				set: { isPresented in
					if isPresented == nil {
						model.dismissButtonTapped()
					}
				}
			),
			onDismiss: { model.dismissButtonTapped() },
			content: { model in
				NavigationStack {
					ExerciseView(model: model)
						.navigationTitle("New exercise!")
						.toolbar {
							ToolbarItem(placement: .cancellationAction) {
								Button("Cancel") {
									self.model.dismissButtonTapped()
								}
							}
							ToolbarItem(placement: .primaryAction) {
								Button("Add") {
									self.model.confirmAddButtonTapped(exercise: model.exercise)
								}
								.disabled(model.exerciseButtonDisabled)
							}
						}
				}
			}
		)
		.navigationDestination(
			item: Binding(
				get: { model.destination?.exerciseToEdit },
				set: { isPresented in
					if isPresented == nil {
						model.dismissButtonTapped()
					}
				}
			)
		) { model in
			NavigationStack {
				ExerciseView(model: model)
					.navigationTitle("Edit exercise")
					.navigationBarBackButtonHidden()
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button("Cancel") {
								self.model.dismissButtonTapped()
							}
						}
						ToolbarItem(placement: .primaryAction) {
							Button("Edit") {
								self.model.confirmEditButtonTapped(exercise: model.exercise)
							}
							.disabled(model.exerciseButtonDisabled)
						}
					}
			}
		}
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
			titleVisibility: .visible,
			presenting: model.destination?.exerciseToUpdate
		) { exercise in
			ForEach(
				Exercise.Mode.allCases.filter { $0 != exercise.type },
				id: \.self
			) { type in
				Button(type.rawValue.capitalized) {
					withAnimation { model.confirmDialogButtonTapped(type: type) }
				}
			}
		} message: { _ in
			Text("Choose a new option for the exercise type.")
		}
		.toolbar {
				ToolbarItem(placement: .confirmationAction) {
						Button {
								model.addExerciseButtonTapped()
						} label: {
								Image(systemName: "plus")
						}
				}
		}
	}
}

#Preview {
	NavigationStack {
		ExercisesView(
			model: ExercisesModel(
				exercises: (0..<5).map { _ in
					Exercise.fake(.random)
				}
			)
		)
	}
}
