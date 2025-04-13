import SwiftUI

struct ExercisesView: View {
	let model: ExercisesModel
	
	var body: some View {
		List {
			ForEach(model.exercises) { exercise in
				ExerciseRowView(exercise: exercise)
			}
		}
		.listRowSpacing(8)
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
