//
//  ViewController.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 24/11/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import UIKit
import CoreData

class MainTableVC: UITableViewController {
    
    var cells: [Cell] = []
    
    private var fetchedResultsController: NSFetchedResultsController<MOImage> = {
        let controller = CoreDataManager.shared.getFetchedResultsController()
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "100 Cells App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for i in 1...100 {
            cells.append(Cell(imgURL: "https://picsum.photos/id/\(i+100)/200/200", fullImgURL: "https://picsum.photos/id/\(i+100)/500/500", img: nil, imgFull: nil))
            // API не выдает пикчи 38, 48 и 50, приходится фиксить хардкодом снизу
            if i == 5 || i == 38 || i == 48 || i == 50 {
                cells[cells.count-1].imgURL = "https://picsum.photos/id/100/200/200"
                cells[cells.count-1].fullImgURL = "https://picsum.photos/id/100/500/500"
            }
        }
        
        if let fetchedResults = fetchedResultsController.fetchedObjects {
            print(fetchedResults.count)
            for i in fetchedResults {
                cells[Int(i.id)].img = UIImage(data: i.tab)
                cells[Int(i.id)].imgFull = UIImage(data: i.full)
            }
        }

        tableView.register(MainTableVCCell.self
            , forCellReuseIdentifier: MainTableVCCell.reuseId)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadVisibleCellsImages()
    }
    
    private func loadVisibleCellsImages() {
        for cell in self.tableView.visibleCells {
            guard let indexPath = self.tableView.indexPath(for: cell) else {continue}
            let url = self.cells[indexPath.row].imgURL
            if cells[indexPath.row].img == nil {
                NetworkManager.shared.downloadImage(link: url, completion: { image in
                    self.cells[indexPath.row].img = image
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                    self.pushToCoreData(cell: self.cells[indexPath.row], id: Int16(indexPath.row))
                })
            }
            let fullUrl = self.cells[indexPath.row].fullImgURL
            if cells[indexPath.row].imgFull == nil {
                NetworkManager.shared.downloadImage(link: fullUrl, completion: { image in
                    self.cells[indexPath.row].imgFull = image
                    self.pushToCoreData(cell: self.cells[indexPath.row], id: Int16(indexPath.row))
                })
            }
        }
    }
    
    private func pushToCoreData(cell: Cell, id: Int16) {
        guard let fullImg = cell.imgFull, let tabImg = cell.img else {return}
        guard let fullData = fullImg.pngData(), let tabData = tabImg.pngData() else {return}
        CoreDataManager.shared.saveImage(id: id, tab: tabData, full: fullData)
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
        if let fullImg = cells[indexPath.row].imgFull {
            expandedView.imgView.image = fullImg
        }
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
    var imgURL: String
    var fullImgURL: String
    var img: UIImage?
    var imgFull: UIImage?
}
