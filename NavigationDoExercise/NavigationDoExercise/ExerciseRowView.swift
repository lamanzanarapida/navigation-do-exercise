import SwiftUI

struct ExerciseRowView: View {
	let exercise: Exercise
	
	var body: some View {
		HStack(alignment: .top) {
			Image(systemName: exercise.type.systemImage)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
				.foregroundStyle(exercise.color)
			Spacer()
			VStack(alignment: .leading) {
				HStack {
					Text(exercise.title)
						.lineLimit(1)
					Spacer()
					Text(exercise.startsFormatted)
						.foregroundStyle(.gray)
				}
				HStack(alignment: .lastTextBaseline) {
					Text(exercise.distanceFormatted)
						.font(.system(size: 24))
						.foregroundStyle(exercise.color)
					Spacer()
					Text(exercise.duration)
						.foregroundStyle(.gray)
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		List {
			ForEach(
				Exercise.Mode.allCases.map(Exercise.fake(type:))
			) { item in
				ExerciseRowView(exercise: item)
			}
		}
		.listRowSpacing(8)
	}
}
