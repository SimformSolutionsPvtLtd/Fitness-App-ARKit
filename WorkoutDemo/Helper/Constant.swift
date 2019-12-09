//
//  Constant.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 28/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit

// MARK: - Constants
struct Model {
    static let path = "Models.scnassets/WorkoutModel/"
    static let `extension` = ".dae"
}

struct AnimationKey {
    static let speed = "unnamed_animation__0"
}

struct Key {
    static let workoutSpeed = "workout_speed"
    static let workoutSpeedValue = "workout_speed_value"
}

struct Segue {
    static let workout = "workout_segue"
}

struct CustomFont {
    static let nexaBold = "NexaBold"
}

struct TableViewCell {
    static let identifier = "cell"
}

struct Cell {
    static let height: CGFloat = 83
}

struct Slider {
    static let value: Float = 70
    static let valueDividedBy: Float = 100
}

struct Animation {
    static let durationForHidingLabel = 2.0
    static let durationForBlurEffect = 0.5
}

struct Image {
    static let play = UIImage(systemName: "play.fill")
    static let pause = UIImage(systemName: "pause.fill")
}

// MARK: - Workout Enum
enum Workout: String, CaseIterable {
    case airSquat = "Air Squat"
    case bicycleCrunch = "Bicycle Crunch"
    case burpee = "Burpee"
    case crawlingBackwards = "Crawling Backwards"
    case jumpingJacks = "Jumping Jacks"
    case pistol = "Pistol"
    case pushUp = "Push Up"
    case running = "Running"
    case situps = "Situps"
    case warmingUp = "Warming Up"
    
    var modelName: String {
        switch self {
        case .airSquat:
            return "AirSquat"
        case .bicycleCrunch:
            return "BicycleCrunch"
        case .burpee:
            return "Burpee"
        case .crawlingBackwards:
            return "CrawlingBackwards"
        case .jumpingJacks:
            return "JumpingJacks"
        case .pistol:
            return "Pistol"
        case .pushUp:
            return "PushUp"
        case .running:
            return "Running"
        case .situps:
            return "Situps"
        case .warmingUp:
            return "WarmingUp"
        }
    }
    
}// End of Enum
