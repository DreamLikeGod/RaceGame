//
//  GamePresenter.swift
//  RaceGame
//
//  Created by Егор on 18.02.2024.
//

import Foundation
import UIKit

private extension Double {
    static let standartSpeed: Double = 3.0
    static let playerSpeed: Double = 1.0
}
protocol iGamePresenter {
    func setView(_ view: GameViewController)
    func goLeftOrRight(_ sender: UIButton)
    func prepareForGame()
}
final class GamePresenter: iGamePresenter {
    
    private weak var view: GameViewController?
    
    private let settings = Settings()
    private let records = Records()
    
    private var timers: [Timer] = []
    private var animators: [UIViewPropertyAnimator] = []
    private var enemyCars: [UIView] = []
    private var score = 0
    
    public func goLeftOrRight(_ sender: UIButton) {
        let animator = UIViewPropertyAnimator(duration: .playerSpeed/Double(settings.getSettings().difficulty), curve: .linear)
        animator.addAnimations {
            self.view?.playerCar.transform = self.view!.playerCar.transform.translatedBy(x: self.view!.playerCar.frame.width*2*CGFloat(sender.tag), y: 0)
        }
        animators.append(animator)
        animator.startAnimation()
    }
    public func prepareForGame() {
        self.view?.buttonLeft.isUserInteractionEnabled = false
        self.view?.buttonRight.isUserInteractionEnabled = false
        self.view?.playerCar.backgroundColor = settings.getCarColor(with: settings.getSettings().carColor)
        var time = 6
        self.view?.label.text = "\(time-1)"
        self.view?.configLabel()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            time -= 1
            self.view?.label.text = "\(time-1)"
            if time == 1 {
                self.view?.label.text = "Start"
            } else if time == 0 {
                timer.invalidate()
                self.view?.label.removeFromSuperview()
                self.startGame()
            }
        })
    }
    public func prepareForRestart() {
        for enemyCar in enemyCars.indices {
            enemyCars[enemyCar].removeFromSuperview()
        }
        enemyCars.removeAll()
        for timer in timers {
            timer.invalidate()
        }
        timers.removeAll()
        for animator in animators {
            animator.stopAnimation(true)
        }
        animators.removeAll()
        score = 0
        UIView.animate(withDuration: 0) {
            self.view?.playerCar.transform = .identity
        }
        prepareForGame()
    }
    private func startGame() {
        self.view?.buttonLeft.isUserInteractionEnabled = true
        self.view?.buttonRight.isUserInteractionEnabled = true
        self.view?.configScoreLabel()
        self.view?.scoreLabel.text = """
                                        Score
                                        \(score)
                                     """
        startSpawn()
        addingPoints()
        checkCollisions()
    }
    // MARK: - Collision
    private func checkCollisions(){
        let timer1 = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(checkCollisionWithSands),
                                     userInfo: nil,
                                     repeats: true)
        let timer2 = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(checkCrashWithEnemy),
                                     userInfo: nil,
                                     repeats: true)
        let timer3 = Timer.scheduledTimer(timeInterval: 0.1,
                                          target: self,
                                          selector: #selector(leftOutside),
                                          userInfo: nil,
                                          repeats: true)
        self.timers.append(timer1)
        self.timers.append(timer2)
        self.timers.append(timer3)
    }
    @objc private func checkCollisionWithSands() {
        if let playerFrame = self.view?.playerCar.layer.presentation()?.frame,
           (playerFrame.intersects(self.view!.leftSand.frame) ||
           playerFrame.intersects(self.view!.rightSand.frame)) {
            self.crash()
        }
    }
    @objc private func checkCrashWithEnemy() {
        for enemyCar in enemyCars {
            if let presentationEnemyFrame = enemyCar.layer.presentation()?.frame,
               let presentationPlayerFrame = self.view?.playerCar.layer.presentation()?.frame,
               presentationEnemyFrame.intersects(presentationPlayerFrame) {
                self.crash()
            }
        }
    }
    @objc private func leftOutside() {
        for carIndex in enemyCars.indices {
            if let presentationEnemyFrame = enemyCars[carIndex].layer.presentation()?.frame,
               let presentationPlayerCar = self.view?.playerCar.layer.presentation()?.frame,
               presentationEnemyFrame.origin.y>(presentationPlayerCar.origin.y+presentationPlayerCar.height) {
                self.updateScore(with: 100*self.settings.getSettings().difficulty)
            }
            if let presentationEnemyFrame = enemyCars[carIndex].layer.presentation()?.frame,
               let viewHeight = self.view?.view.frame.height,
               presentationEnemyFrame.origin.y > viewHeight {
                enemyCars[carIndex].removeFromSuperview()
                enemyCars[carIndex].frame.origin.y = 0
                enemyCars[carIndex].layer.removeAllAnimations()
                enemyCars.removeLast()
            }
        }
    }
    private func crash() {
        for animator in animators {
            animator.pauseAnimation()
        }
        for timer in timers {
            timer.invalidate()
        }
        configAlert()
    }
    // MARK: - Enemy
    @objc private func createEnemyCar() {
        //отрисовка врагов
        let enemyCar = UIView()
        enemyCar.frame.size = self.view!.playerCar.frame.size
        enemyCar.backgroundColor = settings.getObstacleColor(with: settings.getSettings().obstacle)
        self.view!.view.addSubview(enemyCar)
        enemyCars.insert(enemyCar, at: 0)
        if Bool.random() {
            enemyCar.frame.origin.y = self.view!.view.frame.origin.y - enemyCar.frame.height
            enemyCar.frame.origin.x = self.view!.view.center.x - enemyCar.frame.width*1.5
        } else {
            enemyCar.frame.origin.y = self.view!.view.frame.origin.y - enemyCar.frame.height
            enemyCar.frame.origin.x = self.view!.view.center.x + enemyCar.frame.width/2
        }
        startAnimation()
    }
    private func startAnimation() {
        //начало анимации врагов
        let animator = UIViewPropertyAnimator(duration: .standartSpeed/Double(settings.getSettings().difficulty), curve: .linear)
        animator.addAnimations {
            for currentEnemy in self.enemyCars.indices {
                self.enemyCars[currentEnemy].frame.origin.y += self.enemyCars[currentEnemy].frame.height*2.5
            }
        }
        animators.append(animator)
        animator.startAnimation()
    }
    private func startSpawn() {
        let spawnTimer = Timer.scheduledTimer(timeInterval: .standartSpeed/Double(settings.getSettings().difficulty),
                                              target: self,
                                              selector: #selector(createEnemyCar),
                                              userInfo: nil,
                                              repeats: true)
        timers.append(spawnTimer)
    }
    // MARK: - Utilities
    private func updateScore(with points: Int) {
        score += points
        self.view?.scoreLabel.text = """
                                        Score
                                        \(score)
                                     """
    }
    private func addingPoints() {
        let timerScore = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateScore(with: self.settings.getSettings().difficulty)
        }
        timers.append(timerScore)
    }
    private func configAlert() {
        self.view?.scoreLabel.removeFromSuperview()
        let alert = UIAlertController(title: "Results", message: "Your score: \(score) p", preferredStyle: .alert)
        let restart = UIAlertAction(title: "Restart", style: .default) { _ in
            self.saveResults()
            self.prepareForRestart()
        }
        let back = UIAlertAction(title: "Back", style: .cancel) { action in
            self.saveResults()
            self.backToMain()
        }
        alert.addAction(restart)
        alert.addAction(back)
        self.view?.present(alert, animated: true)
    }
    private func saveResults() {
        let record = Info(name: settings.getSettings().nickname ?? "Noname",
                          points: score,
                          date: .now,
                          img: settings.getSettings().avatarUrl ?? "")
        records.addNewRecord(record)
    }
    public func setView(_ view: GameViewController) {
        self.view = view
    }
    public func backToMain() {
        self.view?.dismiss(animated: true)
    }
}
