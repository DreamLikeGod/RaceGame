//
//  SettingsViewController.swift
//  RaceGame
//
//  Created by Егор on 10.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let xs: CGFloat = 8
    static let s: CGFloat = 16
    static let m: CGFloat = 32
    static let l: CGFloat = 64
    static let textfieldSize: CGFloat = 15
    static let fontSize: CGFloat = 20
    static let buttonMenuSize: CGFloat = 25
    static let headerSize: CGFloat = 35
    static let minimumCarHeight: CGFloat = 50
}
private extension String {
    static let leftArrow: String = "arrow.left"
    static let rightArrow: String = "arrow.right"
    static let photo: String = "photo.artframe"
    static let settings: String = "Settings"
    static let placeholder: String = "Enter nickname"
    static let obstacle: String = "Obstacle"
    static let carChoose: String = "Choose your car"
    static let difficulty: String = "Difficulty"
    static let easy: String = "Easy"
    static let normal: String = "Normal"
    static let hard: String = "Hard"
    static let menu: String = "Menu"
}
class SettingsViewController: UIViewController {
    
    private let presenter = SettingsPresenter()
    
    private var labelSettings: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .headerSize)
        label.textColor = .textColor
        label.text = .settings
        label.textAlignment = .center
        return label
    }()
    private var userView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonBackground
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = .borderWidth
        return view
    }()
    private var avatarPickerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: .photo), for: .normal)
        button.tintColor = .textColor
        return button
    }()
    private var obstacleView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonBackground
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = .borderWidth
        return view
    }()
    private var obstacleDemo: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private var nextObstacleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: .rightArrow), for: .normal)
        button.tintColor = .textColor
        button.backgroundColor = .systemGray4
        button.tag = 1
        return button
    }()
    private var previousObstacleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: .leftArrow), for: .normal)
        button.tintColor = .textColor
        button.backgroundColor = .systemGray4
        button.tag = -1
        return button
    }()
    private var labelObstacle: UILabel = {
        let label = UILabel()
        label.text = .obstacle
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        return label
    }()
    private var carView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonBackground
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = .borderWidth
        return view
    }()
    private var carDemo: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private var nextCarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: .rightArrow), for: .normal)
        button.tintColor = .textColor
        button.backgroundColor = .systemGray4
        button.tag = 1
        return button
    }()
    private var previousCarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: .leftArrow), for: .normal)
        button.tintColor = .textColor
        button.backgroundColor = .systemGray4
        button.tag = -1
        return button
    }()
    private var labelCar: UILabel = {
        let label = UILabel()
        label.text = .carChoose
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        return label
    }()
    private var difficultyView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonBackground
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = .borderWidth
        return view
    }()
    private var labelDifficulty: UILabel = {
        let label = UILabel()
        label.text = .difficulty
        label.textAlignment = .center
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        return label
    }()
    private var stackButtons: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = .s
        return view
    }()
    private var easyDiffButton: UIButton = {
        let button = UIButton()
        button.setTitle(.easy, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.setTitleColor(.textColor, for: .normal)
        button.backgroundColor = .systemGray4
        button.tag = Difficulty.easy.rawValue
        return button
    }()
    private var normalDiffButton: UIButton = {
        let button = UIButton()
        button.setTitle(.normal, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.setTitleColor(.textColor, for: .normal)
        button.backgroundColor = .systemGray4
        button.tag = Difficulty.normal.rawValue
        return button
    }()
    private var hardDiffButton: UIButton = {
        let button = UIButton()
        button.setTitle(.hard, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .fontSize)
        button.setTitleColor(.textColor, for: .normal)
        button.backgroundColor = .systemGray4
        button.tag = Difficulty.hard.rawValue
        return button
    }()
    private var backButton: UIButton = {
        let button = UIButton()
        button.setTitle(.menu, for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: .buttonMenuSize)
        button.backgroundColor = .buttonBackground
        button.titleLabel?.snp.makeConstraints({ make in
            make.left.equalToSuperview().offset(CGFloat.s)
            make.right.equalToSuperview().inset(CGFloat.s)
        })
        button.layer.cornerRadius = .cornerRadius
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    public var userImg: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        return img
    }()
    public var userName: UITextField = {
        let field = UITextField()
        field.placeholder = .placeholder
        field.font = .systemFont(ofSize: .textfieldSize)
        field.backgroundColor = .systemGray4
        field.textColor = .textColor
        field.layer.cornerRadius = .cornerRadius
        return field
    }()
    public var obstacleChoosed: Int = 1
    public var carChoosed: Int = 0
    public var diffChoosed: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        // Do any additional setup after loading the view.
    }
    
    private func configLabelSettings() {
        view.addSubview(labelSettings)
        labelSettings.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.l)
            make.left.equalToSuperview().offset(CGFloat.m)
            make.right.equalToSuperview().inset(CGFloat.m)
        }
    }
    private func configUserView() {
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.top.equalTo(labelSettings.snp.bottom).offset(CGFloat.m)
            make.left.equalToSuperview().offset(CGFloat.m)
            make.height.equalTo(userView.snp.width)
        }
    }
    private func configUserImg() {
        view.addSubview(userImg)
        userImg.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.top).offset(CGFloat.s)
            make.left.equalTo(userView.snp.left).offset(CGFloat.m)
            make.right.equalTo(userView.snp.right).inset(CGFloat.m)
            make.width.equalTo(userImg.snp.height)
        }
    }
    private func configAvatarPickerButton() {
        view.addSubview(avatarPickerButton)
        avatarPickerButton.snp.makeConstraints { make in
            make.edges.equalTo(userImg)
        }
        let action = UIAction { _ in
            self.presenter.setAvatar { avatar in
                self.userImg.image = avatar
            }
        }
        avatarPickerButton.addAction(action, for: .touchUpInside)
    }
    private func configUserTextfield() {
        view.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.bottom.equalTo(userView.snp.bottom).inset(CGFloat.s)
            make.top.equalTo(userImg.snp.bottom).offset(CGFloat.xs)
            make.left.equalTo(userView.snp.left).offset(CGFloat.s)
            make.right.equalTo(userView.snp.right).inset(CGFloat.s)
        }
    }
    private func configObstacleView() {
        view.addSubview(obstacleView)
        obstacleView.snp.makeConstraints { make in
            make.top.equalTo(labelSettings.snp.bottom).offset(CGFloat.m)
            make.left.equalTo(userView.snp.right).offset(CGFloat.s)
            make.right.equalToSuperview().inset(CGFloat.m)
            make.size.equalTo(userView.snp.size)
        }
    }
    private func configObstacleDemo() {
        view.addSubview(obstacleDemo)
        obstacleDemo.snp.makeConstraints { make in
            make.top.equalTo(obstacleView.snp.top).offset(CGFloat.s)
            make.width.equalTo(obstacleDemo.snp.height)
        }
        obstacleDemo.backgroundColor = presenter.getObstacle(with: self.obstacleChoosed)
    }
    private func configPreviousObstacle() {
        view.addSubview(previousObstacleButton)
        previousObstacleButton.snp.makeConstraints { make in
            make.left.equalTo(obstacleView.snp.left).offset(CGFloat.s)
            make.right.equalTo(obstacleDemo.snp.left)
            make.top.bottom.equalTo(obstacleDemo)
        }
        let action = UIAction { _ in
            self.pickObstacle(self.previousObstacleButton)
        }
        previousObstacleButton.addAction(action, for: .touchUpInside)
    }
    private func configNextObstacle() {
        view.addSubview(nextObstacleButton)
        nextObstacleButton.snp.makeConstraints { make in
            make.right.equalTo(obstacleView.snp.right).inset(CGFloat.s)
            make.left.equalTo(obstacleDemo.snp.right)
            make.top.bottom.equalTo(obstacleDemo)
        }
        let action = UIAction { _ in
            self.pickObstacle(self.nextObstacleButton)
        }
        nextObstacleButton.addAction(action, for: .touchUpInside)
    }
    private func configLabelObstacle() {
        view.addSubview(labelObstacle)
        labelObstacle.snp.makeConstraints { make in
            make.bottom.equalTo(obstacleView.snp.bottom).inset(CGFloat.s)
            make.top.equalTo(obstacleDemo.snp.bottom).offset(CGFloat.xs)
            make.centerX.equalTo(obstacleDemo.snp.centerX)
        }
    }
    private func configCarView() {
        view.addSubview(carView)
        carView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(CGFloat.m)
            make.left.equalTo(userView.snp.left)
            make.right.equalTo(obstacleView.snp.right)
        }
    }
    private func configCarDemo() {
        view.addSubview(carDemo)
        carDemo.snp.makeConstraints { make in
            make.bottom.equalTo(carView.snp.bottom).inset(CGFloat.m)
            make.top.equalTo(labelCar.snp.bottom).offset(CGFloat.s)
            make.centerX.equalTo(carView.snp.centerX)
            make.height.greaterThanOrEqualTo(CGFloat.minimumCarHeight)
            make.width.equalTo(carDemo.snp.height).multipliedBy(2)
        }
        carDemo.backgroundColor = presenter.getCarColor(with: self.carChoosed)
    }
    private func configNextCar() {
        view.addSubview(nextCarButton)
        nextCarButton.snp.makeConstraints { make in
            make.right.equalTo(carView.snp.right).inset(CGFloat.l)
            make.top.equalTo(carView.snp.top).offset(CGFloat.m)
            make.bottom.equalTo(carView.snp.bottom).inset(CGFloat.s)
        }
        let action = UIAction { _ in
            self.pickCar(self.nextCarButton)
        }
        nextCarButton.addAction(action, for: .touchUpInside)
    }
    private func configPreviousCar() {
        view.addSubview(previousCarButton)
        previousCarButton.snp.makeConstraints { make in
            make.left.equalTo(carView.snp.left).offset(CGFloat.l)
            make.top.equalTo(carView.snp.top).offset(CGFloat.m)
            make.bottom.equalTo(carView.snp.bottom).inset(CGFloat.s)
        }
        let action = UIAction { _ in
            self.pickCar(self.previousCarButton)
        }
        previousCarButton.addAction(action, for: .touchUpInside)
    }
    private func configLabelCar() {
        view.addSubview(labelCar)
        labelCar.snp.makeConstraints { make in
            make.top.equalTo(carView.snp.top).offset(CGFloat.xs)
            make.centerX.equalTo(carView.snp.centerX)
        }
    }
    private func configDifficultyView() {
        view.addSubview(difficultyView)
        difficultyView.snp.makeConstraints { make in
            make.top.equalTo(carView.snp.bottom).offset(CGFloat.m)
            make.left.right.equalTo(carView)
        }
    }
    private func configDiffLabel() {
        view.addSubview(labelDifficulty)
        labelDifficulty.snp.makeConstraints { make in
            make.centerX.equalTo(difficultyView.snp.centerX)
            make.top.equalTo(difficultyView.snp.top).offset(CGFloat.s)
        }
    }
    private func configDiffButtons() {
        view.addSubview(stackButtons)
        stackButtons.addArrangedSubview(easyDiffButton)
        stackButtons.addArrangedSubview(normalDiffButton)
        stackButtons.addArrangedSubview(hardDiffButton)
        stackButtons.snp.makeConstraints { make in
            make.left.equalTo(difficultyView.snp.left).offset(CGFloat.m)
            make.right.equalTo(difficultyView.snp.right).inset(CGFloat.m)
            make.bottom.equalTo(difficultyView.snp.bottom).inset(CGFloat.s)
            make.top.equalTo(labelDifficulty.snp.bottom).offset(CGFloat.s)
        }
        stackButtons.viewWithTag(diffChoosed)?.layer.borderWidth = .borderWidth
        stackButtons.viewWithTag(diffChoosed)?.layer.borderColor = UIColor.white.cgColor
        let action = UIAction { _ in
            self.diffChosed(self.easyDiffButton)
        }
        easyDiffButton.addAction(action, for: .touchUpInside)
        let action2 = UIAction { _ in
            self.diffChosed(self.normalDiffButton)
        }
        normalDiffButton.addAction(action2, for: .touchUpInside)
        let action3 = UIAction { _ in
            self.diffChosed(self.hardDiffButton)
        }
        hardDiffButton.addAction(action3, for: .touchUpInside)
    }
    private func configBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(difficultyView.snp.bottom).offset(CGFloat.l)
            make.centerX.equalToSuperview()
        }
        let action = UIAction { _ in
            self.presenter.backToMain()
        }
        backButton.addAction(action, for: .touchUpInside)
    }
    private func pickObstacle(_ sender: UIButton) {
        self.obstacleChoosed += sender.tag
        switch obstacleChoosed {
        case ..<0:
            obstacleChoosed = 2
        case 3...:
            obstacleChoosed = 0
        default:
            print(obstacleChoosed)
        }
        setupObstacle(with: obstacleChoosed)
    }
    private func setupObstacle(with index: Int) {
        self.obstacleDemo.backgroundColor = presenter.getObstacle(with: index)
    }
    private func pickCar(_ sender: UIButton) {
        self.carChoosed += sender.tag
        switch carChoosed {
        case ..<0:
            carChoosed = 2
        case 3...:
            carChoosed = 0
        default:
            print(carChoosed)
        }
        setupCar(with: carChoosed)
    }
    private func setupCar(with index: Int) {
        self.carDemo.backgroundColor = presenter.getCarColor(with: index)
    }
    private func diffChosed(_ sender: UIButton) {
        Difficulty.allCases.forEach { dif in
            if let btn = self.stackButtons.viewWithTag(dif.rawValue) {
                btn.layer.borderWidth = .zero
                btn.layer.borderColor = .none
            }
            if dif.rawValue == sender.tag {
                if let selectBtn = self.stackButtons.viewWithTag(sender.tag) {
                    selectBtn.layer.borderWidth = .borderWidth
                    selectBtn.layer.borderColor = UIColor.white.cgColor
                    self.diffChoosed = sender.tag
                }
            }
        }
    }
    private func configureScreen() {
        view.backgroundColor = .viewBackground
        presenter.setView(self)
        presenter.setCurrentSettings()
        configLabelSettings()
        configUserView()
        configUserImg()
        configAvatarPickerButton()
        configUserTextfield()
        configObstacleView()
        configObstacleDemo()
        configPreviousObstacle()
        configNextObstacle()
        configLabelObstacle()
        configCarView()
        configLabelCar()
        configCarDemo()
        configNextCar()
        configPreviousCar()
        configDifficultyView()
        configDiffLabel()
        configDiffButtons()
        configBackButton()
    }
}
