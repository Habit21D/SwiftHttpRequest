//
//  DMCell.swift
//  HttpRequest
//
//  Created by 易金 on 2018/1/5.
//  Copyright © 2018年 jin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
class DMCell: UITableViewCell {

    var album: DMModelAlbums? {
        didSet {
            uploadUI()
        }
    }
    
    let iconImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let timeLabel: UILabel = UILabel()
    
    func UISet() {
        iconImageView.backgroundColor = UIColor.lightGray
        nameLabel.textColor = UIColor.red
        timeLabel.textColor = UIColor.gray
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        UISet()
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(timeLabel)
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
            maker.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(iconImageView.snp.right)
            maker.right.equalToSuperview().offset(-10)
            maker.top.equalTo(iconImageView).offset(10)
        }
        
        timeLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(nameLabel)
            maker.bottom.equalTo(iconImageView).offset(-10)
        }
    }

}

extension DMCell {
    
    func uploadUI() {
        guard let model = album else {
            return
        }
        
        if let cover = model.cover {
            let url = URL(string: cover)
            iconImageView.kf.setImage(with: url)
        }
       
        nameLabel.text = model.name
        
        timeLabel.text = model.release_date
    }
}
