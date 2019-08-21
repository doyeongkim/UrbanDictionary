//
//  SearchTableCell.swift
//  UrbanDictionary
//
//  Created by Doyeong's MacBookPro on 21/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableCell: UITableViewCell {
    static let identifier = "SearchTableCell"
    
    let labelInTableWhileSearching: UILabel = {
        let label = UILabel()
//        label.text = """
//        FF - One of it's meanings is a league term for Forfeit. It's commonly used as a league term meaning to surrenderk, also because to surrender one of the commands can be ff.
//""".maxLength(length: 96)
        label.numberOfLines = 0
        
        return label
    }()
    
    
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
        labelInTableWhileSearching.maxLength(first: "FF ",
                                        second: "- One of it's meanings is a league term for Forfeit. It's commonly used as a league term meaning to surrenderk, also because to surrender one of the commands can be ff.",
                                        length: 92)
        contentView.addSubview(labelInTableWhileSearching)
    }
    
    private func setAutolayout() {
        labelInTableWhileSearching.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
