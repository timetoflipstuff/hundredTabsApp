//
//  NetworkManager.swift
//  HundredCells
//
//  Created by Alex Mikhaylov on 29/11/2019.
//  Copyright © 2019 Pink Team. All rights reserved.
//

import Foundation
import UIKit

final class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}
    
    func downloadImage(link: String, completion: @escaping(UIImage) -> Void) {
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data : Data?, response: URLResponse?, error : Error?) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
    
}
