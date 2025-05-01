import Foundation
import SwiftUI

struct Exercise: Identifiable, Equatable {
	let id: UUID
	let distance: Double
	let title: String
	let starts: Date
	let finished: Date?
	var type: Mode
	
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

extension Exercise {
	enum FakeStrategy {
		case random
	}
	static func fake(_ strategy: FakeStrategy) -> Self {
		let id = UUID()
		let randomDate: Date = Date.randomBetween(start: "2025-04-01", end: "2025-05-01")
		return Self(
			id: id,
			distance: Double.random(in: 0..<50),
			title: "This is exercise \(id.uuidString)",
			starts: randomDate,
			finished: randomDate.addingTimeInterval(TimeInterval.random(in: 0..<3600)),
			type: Mode.allCases.randomElement()!
		)
	}
}

fileprivate extension Date {
	static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> Date {
		let date1 = Date.parse(start, format: format)
		let date2 = Date.parse(end, format: format)
		return Date.randomBetween(start: date1, end: date2)
	}
	
	private static func randomBetween(start: Date, end: Date) -> Date {
		var date1 = start
		var date2 = end
		if date2 < date1 {
			let temp = date1
			date1 = date2
			date2 = temp
		}
		let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
		return Date(timeIntervalSinceNow: span)
	}
	
	private func dateString(_ format: String = "yyyy-MM-dd") -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}
	
	private static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = NSTimeZone.default
		dateFormatter.dateFormat = format
		
		let date = dateFormatter.date(from: string)!
		return date
	}
}
