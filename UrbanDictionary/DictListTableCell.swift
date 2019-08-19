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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let definitionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        zOMG is a varient of the all-too-popular acronym "OMG", meaning "Oh My God".
        
        The "z" was originally a mistake white attempting to hit the shift key with the left hand, and type "OMG"
        """
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let exampleLabel: UILabel = {
        let label = UILabel()
        label.text = """
        "zOMG! you r teh winz!!one!!eleven!"
        """
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "ectweak"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let postDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Aug 6, 2005"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        return label
    }()
    
    
    
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
        }
        
        postDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(exampleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(-20)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
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
    }
}


class ButtonView: UIView {
    let btnContainerView: UIView = {
        let view = UIView()
        return view
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
        
    }
    
    private func setAutolayout() {
        
    }
}
