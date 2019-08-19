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
    
    let decoder = JSONDecoder()
    let basicUrl = "http://api.urbandictionary.com/v0/define?term="
    var listArray = [List]()
    
    let dateFormatter = DateFormatter()
    var dateString: Date?
    
    
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
        
        topSearchView.delegate = self
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
    
    private func getServerData(word: String) {
        let urlString = basicUrl + word
        
        guard let apiURL = URL(string: urlString) else { print("wrong url!"); return }

        let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard error == nil else { print("error"); return }
            guard let data = data else { print("data error"); return }

            do {
                let listObject = try? self.decoder.decode(UrbanDictionaryData.self, from: data)
                self.listArray = listObject?.list ?? []
//                print("listArray: ", self.listArray)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}


// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dictListCell = tableView.dequeueReusableCell(withIdentifier: DictListTableCell.identifier, for: indexPath) as! DictListTableCell
        
        dictListCell.setData(listData: listArray[indexPath.row])
        
        return dictListCell
    }
}

// MARK: - TopSearchViewDelegate
extension MainViewController: TopSearchViewDelegate {
    func searchWord(wordString: String) {
        getServerData(word: wordString)
    }
}
