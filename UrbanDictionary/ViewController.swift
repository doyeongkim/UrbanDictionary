//
//  ViewController.swift
//  UrbanDictionary
//
//  Created by Solji Kim on 16/08/2019.
//  Copyright © 2019 Doyeong Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let decoder = JSONDecoder()
    let basicURL = "http://api.urbandictionary.com/v0/define?term="
    var listArray = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getServerData()
    }
    

    func getServerData() {
        let apiURL = URL(string: "http://api.urbandictionary.com/v0/define?term=word")!
        
        let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            guard error == nil else { print("error"); return }
            guard let data = data else { print("data error"); return }
            
            do {
                let listObject = try? self.decoder.decode(UrbanDictionaryData.self, from: data)
                self.listArray = listObject?.list ?? []
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

