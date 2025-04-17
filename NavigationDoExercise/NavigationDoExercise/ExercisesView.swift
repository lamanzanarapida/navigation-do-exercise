import SwiftUI

struct ExercisesView: View {
	let model: ExercisesModel
	
	var body: some View {
		List {
			ForEach(model.exercises) { exercise in
				ExerciseRowView(exercise: exercise)
			}
			.onDelete { indexSet in
				model.onDeleteExercises(indexSet)
			}
		}
		.listRowSpacing(8)
		.alert(
			"Delete exercise",
			isPresented: .constant(true),
			presenting: Exercise.fake(type: .cycling)
		) { exercise in
			Button("Remove \(exercise.type.rawValue)", role: .destructive) {}
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
