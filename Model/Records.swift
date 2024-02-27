//
//  RecordInfo.swift
//  RaceGame
//
//  Created by Егор on 09.02.2024.
//

import Foundation

protocol iRecords {
    func getRecords() -> [Info]
    func addNewRecord(_ record: Info)
}
struct Info: Codable {
    var name: String
    var points: Int
    var date: Date
    var img: String
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}
final class Records: iRecords {
    private var identifier: String { "\(Self.self)" }
    private var array: [Info] {
        get {
            guard let data = UserDefaults.standard.value(with: [Info].self, forKey: identifier) else { return [] }
            return data
        }
        set {
            UserDefaults.standard.set(newValue, forKey: identifier)
        }
    }
    public func getRecords() -> [Info] {
        return self.array.sorted(by: {
            $0.points > $1.points
        })
    }
    public func addNewRecord(_ record: Info) {
        array.append(record)
    }
}
