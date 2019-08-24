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
    let searchTableView = SearchingTableView()
    
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
    var randomWordListArray = [String]()
    var randomListArray = [List]()
    var wordText = String()
    
    // 처음 메인에 보여질 main 케이스 / 푸쉬되서 보여질 push 케이스
    enum VCType {
        case main
        case push
    }
    
    var currentType = VCType.main
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
        
        getRandomData()
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
        
        view.addSubview(searchTableView)
        view.sendSubviewToBack(searchTableView)
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
        
        searchTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topSearchView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

    private func getRandomData() {
        switch currentType {
        
        case .main:
            
            generateRandom5Word()
            
            for i in 0..<randomWordListArray.count {
                getServerData(word: randomWordListArray[i]) { list in
                    
                    self.randomListArray.append(list[0])
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
        case .push:
            getServerData(word: wordText) { list in
                self.randomListArray = list
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.topSearchView.textFieldStartAnimate()
                }
            }
        }
    }
    
    // random 5 word generate
    private func generateRandom5Word() -> [String] {
        randomWordListArray.removeAll()
        
        let wordList = ["tap water", "and i oop-", "well up", "Crick", "fuck-you friday", "a thing", "unemployee", "windjammer", "big cap", "number neighbor", "Settler", "G Code", "genderqueer", "primetiming", "death drop"]
   
        // 랜덤 돌릴때 모두 다른 단어가 들어오게
        var count = 0
        
        for _ in 0... {
            let word = wordList.randomElement() ?? ""

            if randomWordListArray.contains(word) {
                continue
            }
            
            randomWordListArray.append(word)
            
            count += 1
            
            if count == 5 {
                break
            }
        }
        
        return randomWordListArray
    }
    
    
    private func getServerData(word: String, completion: @escaping ([List]) -> ()) {
        let urlString = basicUrl + word
        let newUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let apiURL = URL(string: newUrlString) else { print("wrong url!"); return }

        let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard error == nil else { print("error"); return }
            guard let data = data else { print("data error"); return }

            do {
                let listObject = try? self.decoder.decode(UrbanDictionaryData.self, from: data)
//                self.listArray = listObject?.list ?? []
//                self.searchTableView.listArray = self.listArray
                
                completion(listObject?.list ?? [])
                
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
        return randomListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dictListCell = tableView.dequeueReusableCell(withIdentifier: DictListTableCell.identifier, for: indexPath) as! DictListTableCell
        
        dictListCell.setData(listData: randomListArray[indexPath.row])
        
        if indexPath.row == randomListArray.count - 1 {
            dictListCell.separatorView.backgroundColor = .clear
        } else {
            dictListCell.separatorView.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        }
        
        return dictListCell
    }
}

// MARK: - TopSearchViewDelegate
extension MainViewController: TopSearchViewDelegate {
    func searchWord(wordString: String, searchCase: SearchCases) {
        
        getServerData(word: wordString) { list in
            DispatchQueue.main.async {
                
                switch searchCase {
                
                case .inMain:
                    self.view.sendSubviewToBack(self.searchTableView)
                    
                    let mainVC = MainViewController()
                    mainVC.wordText = wordString
                    mainVC.currentType = .push
                    self.navigationController?.pushViewController(mainVC, animated: true)
                    
                case .inSearch:
//                    print("wordstring: ", wordString)
                    self.searchTableView.listArray = list
                    self.searchTableView.tableView.reloadData()
                }
            }
        }
    }

    func bringSearchTableViewToFront() {
        self.view.bringSubviewToFront(searchTableView)
    }
    
    func sendSearchTableViewToBack() {
        self.view.sendSubviewToBack(searchTableView)
        
        // 전에 vc로 돌아갔을때 backBtn 에니메이션 작동안함
        navigationController?.popViewController(animated: true)
    }
}
