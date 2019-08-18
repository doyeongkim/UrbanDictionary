//
//  TopSearchView.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

class TopSearchView: UIView {
    
    let tfContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "searchIcon")
        view.addSubview(searchIcon)
        searchIcon.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
            make.width.height.equalTo(20)
        })
        
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 4
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Type any word...",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
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
        self.backgroundColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        
        self.addSubview(tfContainerView)
        
        textField.delegate = self
        tfContainerView.addSubview(textField)
    }
    
    private func setAutolayout() {
        tfContainerView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.45)
            make.leading.equalTo(20).priority(500)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-12)
            
        }
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(40)
            make.trailing.equalTo(-20)
        }
    }
}


// MARK: - UITextFieldDelegate

extension TopSearchView: UITextFieldDelegate {
    // hmm
}
