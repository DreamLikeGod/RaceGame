//
//  ViewController.swift
//  RaceGame
//
//  Created by Егор on 09.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let offset: CGFloat = 16
    static let fontSize: CGFloat = 30
    static let marginButtons: CGFloat = 32
}
private extension String {
    static let startButton: String = "Start game"
    static let settingsButton: String = "Settings"
    static let recordsButton: String = "Records"
}

class MainViewController: UIViewController {
    
    static var identifier: String { "\(Self.self)" }
    
    private let presenter = MainPresenter()
    
    private let buttonStart: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(.startButton, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = .cornerRadius
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private let buttonSettings: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(.settingsButton, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = .cornerRadius
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private let buttonRecords: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(.recordsButton, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = .cornerRadius
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func addStartButton() {
        view.addSubview(buttonStart)
        buttonStart.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.bottom.equalTo(buttonSettings.snp.top).offset(-CGFloat.marginButtons)
        }
        let action = UIAction { _ in
            self.presenter.goToNext(.game)
        }
        buttonStart.addAction(action, for: .touchUpInside)
    }
    private func addSettingsButton() {
        view.addSubview(buttonSettings)
        buttonSettings.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.center.equalToSuperview()
        }
        let action = UIAction { _ in
            self.presenter.goToNext(.settings)
        }
        buttonSettings.addAction(action, for: .touchUpInside)
    }
    private func addRecordsButton() {
        view.addSubview(buttonRecords)
        buttonRecords.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.top.equalTo(buttonSettings.snp.bottom).offset(CGFloat.marginButtons)
        }
        let action = UIAction { _ in
            self.presenter.goToNext(.records)
        }
        buttonRecords.addAction(action, for: .touchUpInside)
    }
    private func configureView() {
        presenter.setViewController(viewController: self)
        view.backgroundColor = .viewBackground
        addSettingsButton()
        addStartButton()
        addRecordsButton()
    }

}

