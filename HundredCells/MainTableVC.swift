//
//  ViewController.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 24/11/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import UIKit

class MainTableVC: UITableViewController {
    
    var cells: [Cell] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "100 Cells App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for _ in 1...100 {
            cells.append(Cell())
        }

        tableView.register(MainTableVCCell.self
            , forCellReuseIdentifier: MainTableVCCell.reuseId)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableVCCell.reuseId, for: indexPath) as! MainTableVCCell
        cell.label.text = "Cell #\(indexPath.row + 1)"
        //cell.imgView.image = пикча
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigatiorController?.pushViewController(контроллер с пикчей селла)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}

struct Cell {}
