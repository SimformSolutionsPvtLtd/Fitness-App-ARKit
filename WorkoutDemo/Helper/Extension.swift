//
//  Extension.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 29/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit

// MARK: - Notification Name
extension Notification.Name {
    static let workoutSpeed = Notification.Name(Key.workoutSpeed)
}// End of Extension

// MARK: - UINavigationController
extension UINavigationController {
    
    func setCustomFont() {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: CustomFont.nexaBold, size: 17)!]
    }
    
}// End of Extension

// MARK: - UIView {
extension UIView {
    
    func setView(hidden: Bool) { self.isHidden = hidden }
    
    func set(alpha: Int) { self.alpha = 0 }
    
    func setOverlay() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.49).cgColor
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
    }
    
}// End of Extension

// MARK: - UILabel
extension UILabel {
    
    func setSliderLabel() {
        self.textAlignment = .center
        self.backgroundColor = .white
        self.textColor = UIColor(red: 13.0/255.0, green: 77.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.font = UIFont(name: CustomFont.nexaBold, size: 12.0)
        self.text = "Speed"
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
}// End of Extension

// MARK: - UIButton
extension UIButton {
    
    func set(hidden: Bool) { self.isHidden = hidden }
    
    func set(image: UIImage?) {
        guard let image = image else { return }
        self.setImage(image, for: .normal)
    }
    
    func setTintColorOfImage(color: UIColor) { self.tintColor = color }
    
    func setCornerRadius(radius: CGFloat) { self.layer.cornerRadius = radius; self.clipsToBounds = true }
    
}// End of Extension
