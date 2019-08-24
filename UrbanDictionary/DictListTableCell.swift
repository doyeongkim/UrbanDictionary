//
//  DictListTableCell.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

class DictListTableCell: UITableViewCell {
    static let identifier = "DictListTableCell"
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 0.7460134846)
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "zomg"
        label.font = UIFont.boldSystemFont(ofSize: 27)
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.5, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        return label
    }()
    
    let btnContainerView = ButtonView()
    
    let dateFormatter = DateFormatter()
    var dateString: Date?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(wordLabel)
        contentView.addSubview(definitionLabel)
        contentView.addSubview(exampleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(postDateLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(btnContainerView)
    }
    
    private func setAutolayout() {
        wordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.leading.equalTo(20)
        }
        
        definitionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wordLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-30)
        }
        
        exampleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(definitionLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-30)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(exampleLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        postDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(exampleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
        }
        
        btnContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(btnContainerView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    func setData(listData: List) {
        wordLabel.text = listData.word
        definitionLabel.text = listData.definition
        exampleLabel.text = listData.example
        authorLabel.text = listData.author
        
        // date formatter
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = self.dateFormatter.date(from: listData.writtenOn) ?? Date()
        
        let finalDateFormatter = DateFormatter()
        finalDateFormatter.dateFormat = "MMM d, yyyy"
        postDateLabel.text = finalDateFormatter.string(from: date)
        
        btnContainerView.thumbsUpBtn.setTitle(String(listData.thumbsUp), for: .normal)
        btnContainerView.thumbsDownBtn.setTitle(String(listData.thumbsDown), for: .normal)
    }
}


class ButtonView: UIView {

    let thumbsUpBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "thumbsUp"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentHorizontalAlignment = .left
       
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        
        
        return btn
    }()
    
    let thumbsDownBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "thumbsDown"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.contentHorizontalAlignment = .left
       
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        self.layer.cornerRadius = 25
        
        thumbsUpBtn.layer.cornerRadius = 20
        thumbsUpBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.addSubview(thumbsUpBtn)
        
        thumbsDownBtn.layer.cornerRadius = 20
        thumbsDownBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.addSubview(thumbsDownBtn)
    }
    
    private func setAutolayout() {
        thumbsUpBtn.snp.makeConstraints { (make) in
            make.top.leading.equalTo(3)
            make.bottom.equalTo(-3)
            make.width.equalToSuperview().multipliedBy(0.48)
        }
        
        thumbsDownBtn.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.bottom.trailing.equalTo(-3)
            make.width.equalToSuperview().multipliedBy(0.48)
        }
    }
}
