//
//  Extension+ViewController.swift
//  MusicPlayer
//
//  Created by Karma Strategies on 26/01/25.
//

import Foundation
import UIKit
extension UIViewController {
    func showToast(message : String, duration: Int = 4, completionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            
            let toastLabelHeight = round(CGFloat(message.count) / 25.0) * 44
            let toastLabel = UILabel(frame: CGRect(x: 32, y: height - toastLabelHeight - 60, width: width - 64, height: toastLabelHeight))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.numberOfLines = 0
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.3, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
                if let completionHandler = completionHandler {
                    completionHandler()
                }
            })
        }
    }
}
