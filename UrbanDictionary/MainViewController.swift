//
//  MainViewController.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let topSearchView = TopSearchView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(DictListTableCell.self, forCellReuseIdentifier: DictListTableCell.identifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(topSearchView)
        
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setAutolayout() {
        topSearchView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.12)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topSearchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dictListCell = tableView.dequeueReusableCell(withIdentifier: DictListTableCell.identifier, for: indexPath) as! DictListTableCell
        return dictListCell
    }
}
