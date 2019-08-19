//
//  TopSearchView.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

protocol TopSearchViewDelegate: class {
    func searchWord(wordString: String)
}


class TopSearchView: UIView {
    
    weak var delegate: TopSearchViewDelegate?
    
    let tfContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "searchIcon")
        searchIcon.contentMode = .scaleAspectFit
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
        textField.backgroundColor = .clear
        textField.returnKeyType = UIReturnKeyType.search
        textField.attributedPlaceholder = NSAttributedString(string: "Type any word...",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
    }()
    
    let backBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        button.layer.cornerRadius = 20
        return button
    }()
    
    var containerViewLeading: NSLayoutConstraint?
    
    
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
        
        backBtn.addTarget(self, action: #selector(backBtnDidTap(_:)), for: .touchUpInside)
        backBtn.layer.opacity = 0
        self.addSubview(backBtn)
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
        
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(tfContainerView.snp.centerY)
            make.leading.equalTo(10)
            make.width.height.equalTo(40)
        }
    }
    
    @objc private func backBtnDidTap(_ sender: UIButton) {
        textField.resignFirstResponder()
        
        textFieldEndAnimate()
    }
    
    private func textFieldStartAnimate() {
        containerViewLeading = tfContainerView.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 8)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
            self.containerViewLeading?.priority = .defaultHigh
            self.containerViewLeading?.isActive = true
            self.layoutIfNeeded()
        }) { (_) in
            // do sth later
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: [], animations: {
            self.backBtn.layer.opacity = 1
        }) { (_) in
            // do sth here
        }
    }
    
    private func textFieldEndAnimate() {
        UIView.animateKeyframes(withDuration: 0.6, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                self.backBtn.layer.opacity = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
                self.containerViewLeading?.priority = .defaultLow
                
                self.layoutIfNeeded()
            })
        }) { (_) in
            // do sth later
        }
    }
}


// MARK: - UITextFieldDelegate

extension TopSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else { return true }
        
        let text = textField.text ?? ""
        
        delegate?.searchWord(wordString: text)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        print("text: ", text)
        
        textFieldStartAnimate()
    }
}
