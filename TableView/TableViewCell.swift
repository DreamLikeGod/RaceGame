//
//  TableViewCell.swift
//  RaceGame
//
//  Created by Егор on 09.02.2024.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let offset: CGFloat = 10
    static let fontSize: CGFloat = 20
}

class TableViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private var avatarImg: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .black
        return imgView
    }()
    private var labelName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        label.numberOfLines = 0
        return label
    }()
    private var labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        return label
    }()
    private var labelPoints: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .fontSize)
        label.textColor = .textColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        isUserInteractionEnabled = false
        
        contentView.addSubview(avatarImg)
        contentView.addSubview(labelName)
        contentView.addSubview(labelPoints)
        contentView.addSubview(labelDate)
        
        avatarImg.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(CGFloat.offset)
            make.bottom.equalToSuperview().inset(CGFloat.offset)
            make.width.equalTo(avatarImg.snp.height)
        }
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset)
            make.left.equalTo(avatarImg.snp.right).offset(CGFloat.offset)
            make.bottom.equalTo(labelName.snp.bottom)
        }
        labelPoints.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.top.equalToSuperview().offset(CGFloat.offset)
            make.left.equalTo(labelName.snp.right).offset(CGFloat.offset)
            make.bottom.equalTo(labelName.snp.bottom)
        }
        labelDate.snp.makeConstraints { make in
            make.left.equalTo(avatarImg.snp.right).offset(CGFloat.offset)
            make.right.bottom.equalToSuperview().inset(CGFloat.offset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        labelDate.text = ""
        labelName.text = ""
        labelPoints.text = ""
        avatarImg.image = UIImage()
    }
    
    func configureCell(info: Info) {
        labelName.text = info.name
        labelDate.text = info.dateString
        labelPoints.text = "\(info.points) p"
        avatarImg.image = StorageManager().loadImage(from: info.img)
    }
    
}
