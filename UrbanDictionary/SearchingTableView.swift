//
//  SearchingTableView.swift
//  UrbanDictionary
//
//  Created by Doyeong's MacBookPro on 21/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

class SearchingTableView: UIView {
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = #colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
        
        tableView.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
        
        return tableView
    }()
    
    var listArray = [List]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = footerView
        self.addSubview(tableView)
        
//        print("listArray count: ", listArray.count)
    }
    
    private func setAutolayout() {
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDataSource
extension SearchingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as! SearchTableCell
        
        cell.setData(listData: listArray[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchingTableView: UITableViewDelegate {
    
}
