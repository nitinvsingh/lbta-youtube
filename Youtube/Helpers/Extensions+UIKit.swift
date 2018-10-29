
//
//  Extensions+UIKit.swift
//  Youtube
//
//  Created by Nitin Singh on 20/10/18.
//  Copyright © 2018 Cogitate Technology Solution. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIView {
    func addConstraintsWith(format: String, on views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            viewsDictionary["v" + String(index)] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIImageView {
    func loadImageUsingURLString(_ urlString: String) {
        guard let imageURL = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            }.resume()
    }
}
