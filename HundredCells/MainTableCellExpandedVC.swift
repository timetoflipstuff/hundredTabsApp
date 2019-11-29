//
//  MainTableCellExpandedVC.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 29/11/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import UIKit

class MainTableCellExpandedVC: UIViewController {

    let imgView = UIImageView()
    
    override func viewDidLoad() {
        self.imgView.frame = view.frame
        self.imgView.backgroundColor = .darkGray
        
        view.backgroundColor = .white
        
        view.addSubview(imgView)
        
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        self.imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        self.imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive = true
    }
    
}
