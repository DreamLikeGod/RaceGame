//
//  Presenter.swift
//  RaceGame
//
//  Created by Егор on 10.02.2024.
//

import Foundation
import UIKit

enum Views {
    case game
    case settings
    case records
}
final class MainPresenter {
    
    private weak var current: UIViewController?
    
    public func setViewController(viewController: UIViewController) {
        self.current = viewController
    }
    private func presentView(_ view: UIViewController) {
        guard let controller = current else { return }
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
    }
    public func goToNext(_ variant: Views) {
        var vc: UIViewController
        switch variant {
        case .game:
            vc = GameViewController()
        case .settings:
            vc = SettingsViewController()
        case .records:
            vc = RecordsViewController()
        }
        presentView(vc)
    }
    public func backToMain() {
        guard let controller = current else { return }
        controller.dismiss(animated: true)
    }
}
