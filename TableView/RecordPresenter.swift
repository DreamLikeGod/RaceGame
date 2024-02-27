//
//  RecordPresenter.swift
//  RaceGame
//
//  Created by Егор on 18.02.2024.
//

import Foundation

final class RecordPresenter {
    
    private weak var view: RecordsViewController?
    private let model: iRecords = Records()
    
    public func getInfo() -> [Info] {
        model.getRecords()
    }
    public func setView(_ view: RecordsViewController) {
        self.view = view
    }
    public func backToMain() {
        self.view?.dismiss(animated: true)
    }
}
