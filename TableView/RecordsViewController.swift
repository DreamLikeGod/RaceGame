//
//  GameViewController.swift
//  RaceGame
//
//  Created by Егор on 09.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let cellHeight: CGFloat = 100
    static let bigOffset: CGFloat = 50
    static let offset: CGFloat = 25
    static let fontSize: CGFloat = 35
}
private extension String {
    static let records = "Records"
    static let main = "Main menu"
}
class RecordsViewController: UIViewController {
    
    private let presenter = RecordPresenter()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = .records
        label.font = .boldSystemFont(ofSize: .fontSize)
        label.textAlignment = .center
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.separatorColor = .viewBackground
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private var buttonBack: UIButton = {
        let button = UIButton()
        button.setTitle(.main, for: .normal)
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
        configureScreen()
        // Do any additional setup after loading the view.
    }
    
    private func configLabel() {
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.bigOffset)
            make.left.right.equalToSuperview()
        }
    }
    private func configTable() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(CGFloat.offset)
        }
    }
    private func configButton() {
        self.view.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(CGFloat.bigOffset)
            make.centerX.equalToSuperview()
            make.top.equalTo(tableView.snp.bottom).offset(CGFloat.offset)
            make.width.equalToSuperview().dividedBy(2)
        }
        let action = UIAction { _ in
            self.presenter.backToMain()
        }
        buttonBack.addAction(action, for: .touchUpInside)
    }
    private func configureScreen() {
        presenter.setView(self)
        view.backgroundColor = .viewBackground
        configLabel()
        configTable()
        configButton()
    }
}
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getInfo().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return TableViewCell()
        }
        cell.configureCell(info: presenter.getInfo()[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .cellHeight
    }
}
