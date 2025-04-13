import Foundation
import SwiftUI

struct Exercise: Identifiable {
	let id: UUID
	let distance: Double
	let title: String
	let starts: Date
	let finished: Date?
	let type: Mode
	
	var isFinished: Bool {
		finished != nil
	}
	
	enum Mode: String, CaseIterable {
		case cycling = "Cycling", running = "Running", swimming = "Swimming", walking = "Walking"
	}
}

extension Exercise.Mode {
	var systemImage: String {
		switch self {
			case .cycling:
				return "figure.outdoor.cycle.circle"
			case .running:
				return "figure.run.circle"
			case .swimming:
				return "figure.open.water.swim.circle"
			case .walking:
				return "figure.walk.circle"
		}
	}
	
	var color: Color {
		switch self {
			case .cycling:
				return .yellow
			case .running:
				return .green
			case .swimming:
				return .blue
			case .walking:
				return .orange
		}
	}
}

extension Exercise {
	var startsFormatted: String {
		starts.formatted(date: .numeric, time: .omitted)
	}
	
	var duration: String {
		if let finished {
			let diff = Int(finished.timeIntervalSince1970 - starts.timeIntervalSince1970)
			return "\(diff / 60) min"
		} else {
			return "In progress"
		}
	}
	
	var distanceFormatted: String {
		"\(String(format: "%.2f", distance)) KM"
	}
	
	var color: Color {
		type.color
	}
}

extension Exercise {
	static func fake(type: Exercise.Mode) -> Self {
		Self(
			id: UUID(),
			distance: 15.45,
			title: "First exercise of my life",
			starts: .now,
			finished: .now.addingTimeInterval(3600),
			type: type
		)
	}
}
