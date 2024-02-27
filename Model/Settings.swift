//
//  Settings.swift
//  RaceGame
//
//  Created by Егор on 19.02.2024.
//

import Foundation
import UIKit

enum Obstacle: String, CaseIterable {
    case tree = "tree"
    case bush = "bush"
    case stone = "stone"
}
enum Car: String, CaseIterable {
    case race = "race"
    case van = "van"
    case sedan = "sedan"
}
enum Difficulty: Int, Codable, CaseIterable {
    case easy = 1
    case normal = 3
    case hard = 5
}
struct Setting: Codable {
    let nickname: String?
    let avatarUrl: String?
    let obstacle: Int
    let difficulty: Int
    let carColor: Int
}
final class Settings {
    
    private var identifier: String { "\(Self.self)" }
    private var current: Setting {
        get {
            if let data = UserDefaults.standard.value(with: Setting.self, forKey: identifier) {
                return data
            }
            return Setting(nickname: nil, avatarUrl: nil, obstacle: 1, difficulty: 1, carColor: 1)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: identifier)
        }
    }
    private var obstacleArray:[UIColor] {
        var array: [UIColor] = []
        for color in Obstacle.allCases {
            array.append(UIColor(named: color.rawValue)!)
        }
        return array
    }
    private var carArray:[UIColor] {
        var array: [UIColor] = []
        for color in Car.allCases {
            array.append(UIColor(named: color.rawValue)!)
        }
        return array
    }
    func getSettings() -> Setting {
        current
    }
    func getCarColor(with index: Int) -> UIColor {
        carArray[index]
    }
    func getObstacleColor(with index: Int) -> UIColor {
        obstacleArray[index]
    }
    func saveSetting(with newSetting: Setting) {
        self.current = newSetting
    }
}
