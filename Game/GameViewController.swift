//
//  GameViewController.swift
//  RaceGame
//
//  Created by Егор on 10.02.2024.
//

import UIKit
import SnapKit

private extension String {
    static let leftArrow: String = "arrow.left"
    static let rightArrow: String = "arrow.right"
}
private extension CGFloat {
    static let half: CGFloat = 2
    static let quater: CGFloat = 4
    static let halfQuater: CGFloat = 8
    static let scoreFont: CGFloat = 25
    static let buttonFont: CGFloat = 50
    static let timerFont: CGFloat = 100
    static let splitDiv: CGFloat = 25
    static let inset: CGFloat = 50
    static let roadPerc: CGFloat = 0.7
}
class GameViewController: UIViewController {
    
    private let gamePresenter: iGamePresenter = GamePresenter()
    
    private var road: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = .borderWidth
        return view
    }()
    private var splitLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    public var buttonLeft: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: .buttonFont)
        button.setImage(UIImage(systemName: .leftArrow), for: .normal)
        button.backgroundColor = .buttonBackground
        button.tintColor = .textColor
        button.layer.cornerRadius = button.frame.width/CGFloat.half
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        button.tag = -1
        return button
    }()
    public var buttonRight: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: .buttonFont)
        button.setImage(UIImage(systemName: .rightArrow), for: .normal)
        button.backgroundColor = .buttonBackground
        button.tintColor = .textColor
        button.layer.cornerRadius = button.frame.width/CGFloat.half
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = UIColor.white.cgColor
        button.tag = 1
        return button
    }()
    public var leftSand: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()
    public var rightSand: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    public var playerCar: UIView = {
        let car = UIView()
        car.backgroundColor = .black
        return car
    }()
    public var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .timerFont)
        label.textColor = .black
        return label
    }()
    public var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .scoreFont)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
        self.gamePresenter.prepareForGame()
        // Do any additional setup after loading the view.
    }
    
    public func configLabel() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    public func configScoreLabel() {
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(buttonLeft.snp.bottom)
        }
    }
    private func configLeftSand() {
        view.addSubview(leftSand)
        leftSand.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
            make.right.equalTo(road.snp.left)
        }
        leftSand.layoutIfNeeded()
    }
    private func configRightSand() {
        view.addSubview(rightSand)
        rightSand.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.top.equalTo(road.snp.top)
            make.left.equalTo(road.snp.right)
        }
        rightSand.layoutIfNeeded()
    }
    private func configRoad() {
        view.addSubview(road)
        road.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.bottom.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(CGFloat.roadPerc)
        }
        road.layoutIfNeeded()
    }
    private func configSplitLine() {
        view.addSubview(splitLine)
        splitLine.snp.makeConstraints { make in
            make.center.equalTo(road)
            make.width.equalTo(road.snp.width).dividedBy(CGFloat.splitDiv)
            make.height.equalTo(road.snp.height)
        }
    }
    private func configButtonLeft() {
        view.addSubview(buttonLeft)
        buttonLeft.snp.makeConstraints { make in
            make.centerX.equalTo(road.snp.left)
            make.bottom.equalToSuperview().inset(CGFloat.inset)
            make.width.equalTo(buttonLeft.snp.height)
        }
        let action = UIAction { _ in
            self.gamePresenter.goLeftOrRight(self.buttonLeft)
        }
        buttonLeft.addAction(action, for: .touchUpInside)
    }
    private func configButtonRight() {
        view.addSubview(buttonRight)
        buttonRight.snp.makeConstraints { make in
            make.centerX.equalTo(road.snp.right)
            make.bottom.equalToSuperview().inset(CGFloat.inset)
            make.width.equalTo(buttonRight.snp.height)
        }
        let action = UIAction { _ in
            self.gamePresenter.goLeftOrRight(self.buttonRight)
        }
        buttonRight.addAction(action, for: .touchUpInside)
    }
    private func configPlayerCar() {
        view.addSubview(playerCar)
        playerCar.snp.makeConstraints { make in
            make.width.equalTo(road.snp.width).dividedBy(CGFloat.quater)
            make.height.equalTo(playerCar.snp.width).multipliedBy(CGFloat.half)
            make.bottom.equalToSuperview().inset(CGFloat.inset)
            make.right.equalTo(road.snp.right).inset(road.frame.width/CGFloat.halfQuater)
        }
    }
    private func configureScreen() {
        gamePresenter.setView(self)
        configRoad()
        configLeftSand()
        configRightSand()
        configSplitLine()
        configPlayerCar()
        configButtonLeft()
        configButtonRight()
    }
}
