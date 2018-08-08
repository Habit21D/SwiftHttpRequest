//
//  DMCell.swift
//  HttpRequest
//
//  Created by 易金 on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//  多米音乐用来展示的cell

import UIKit
import SnapKit
import Kingfisher
class DMCell: UITableViewCell {

    var model: DMModel.DMRankingList? {
        didSet {
            uploadUI()
        }
    }
    
    let iconImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let descLabel: UILabel = UILabel()
    
    func UISet() {
        iconImageView.backgroundColor = UIColor.lightGray
        nameLabel.textColor = UIColor.black
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 0
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        UISet()
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(descLabel)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeConstraints() {
        iconImageView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
            maker.width.equalTo(130)
            maker.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconImageView.snp.right).offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalTo(iconImageView).offset(10)
        }
        
        descLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconImageView.snp.right).offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.bottom.equalTo(iconImageView).offset(-10)
        }
    }

}

extension DMCell {
    
    func uploadUI() {
        guard let model = model else {
            return
        }
        let url = URL(string: model.cover)
        iconImageView.kf.setImage(with: url)
        
        nameLabel.text = model.title + "榜"
        
        descLabel.text = model.subTitle
    }
}
