//
//  UIImage.swift
//  ExpenseReporter
//
//  Created by Aaron LaBeau on 7/4/23.
//
import UIKit
import Foundation

extension UIImage {
    func scale(to size: CGSize) -> UIImage? {
        let aspectRatio = self.size.width / self.size.height
        let newWidth = size.width
        let newHeight = newWidth / aspectRatio

        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
