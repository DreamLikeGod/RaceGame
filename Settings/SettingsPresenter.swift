//
//  SettingsPresenter.swift
//  RaceGame
//
//  Created by Егор on 19.02.2024.
//

import Foundation
import UIKit

final class SettingsPresenter {
    
    private weak var view: SettingsViewController?
    private let imagePicker: iImagePicker = ImagePicker()
    private let model = Settings()
    private let storageManager = StorageManager()
    
    func setCurrentSettings(){
        let settings = model.getSettings()
        self.view?.userName.text = settings.nickname ?? ""
        self.view?.userImg.image = storageManager.loadImage(from: settings.avatarUrl ?? "")
        self.view?.obstacleChoosed = settings.obstacle
        self.view?.carChoosed = settings.carColor
        self.view?.diffChoosed = settings.difficulty
    }
    func setView(_ view: SettingsViewController) {
        self.view = view
    }
    func setAvatar(with completion: @escaping (UIImage) -> (Void)) {
        imagePicker.showImagePicker(in: view!) { avatar in
            completion(avatar)
        }
    }
    func getCarColor(with index: Int) -> UIColor {
        model.getCarColor(with: index)
    }
    func getObstacle(with index: Int) ->UIColor {
        model.getObstacleColor(with: index)
    }
    private func saveSettings() {
        let img = try? storageManager.saveImage(self.view?.userImg.image ?? UIImage())
        let settings = Setting(nickname: self.view?.userName.text,
                               avatarUrl: img,
                               obstacle: self.view!.obstacleChoosed,
                               difficulty: self.view!.diffChoosed,
                               carColor: self.view!.carChoosed)
        model.saveSetting(with: settings)
    }
    public func backToMain() {
        saveSettings()
        self.view?.dismiss(animated: true)
    }
}
