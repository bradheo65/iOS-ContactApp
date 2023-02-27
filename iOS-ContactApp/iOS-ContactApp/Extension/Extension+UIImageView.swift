//
//  Extension+UIImageView.swift
//  iOS-ContactApp
//
//  Created by brad on 2023/02/26.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                }
            }
        }
    }
}
