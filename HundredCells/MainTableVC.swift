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
        
        for i in 1...100 {
            cells.append(Cell(index: i, imgURL: "https://picsum.photos/id/\(i)/200/200", img: nil))
        }

        tableView.register(MainTableVCCell.self
            , forCellReuseIdentifier: MainTableVCCell.reuseId)
        
        self.loadVisibleCellsImages()
        
    }
    
    private func loadVisibleCellsImages() {
        for cell in self.tableView.visibleCells {
            guard let indexPath = self.tableView.indexPath(for: cell) else {continue}
            let url = self.cells[indexPath.row].imgURL
            if cells[indexPath.row].img == nil {
                NetworkManager.shared.downloadImage(link: url, completion: { image in
                    self.cells[indexPath.row].img = image
                    print("Image for cell \(indexPath.row) loaded")
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                })
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableVCCell.reuseId, for: indexPath) as! MainTableVCCell
        cell.label.text = "Cell #\(indexPath.row + 1)"
        if let img = cells[indexPath.row].img {
            cell.imgView.image = img
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let expandedView = MainTableCellExpandedVC()
        expandedView.imgView.image = cells[indexPath.row].img
        expandedView.title = "Cell #\(indexPath.row + 1)"
        navigationController?.pushViewController(expandedView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadVisibleCellsImages()
    }
    
}

struct Cell {
    var index: Int
    var imgURL: String
    var img: UIImage?
}
