//
//  UIView+Extesnion.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

extension UIView {
    
    @discardableResult
    func background(_ color: UIColor = .systemBackground) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func constrained() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func addAsSubview(of view: UIView) -> Self {
        view.addSubview(self)
        return self
    }
    
    @discardableResult
    func addAndPinAsSubview(of view: UIView, padding: CGFloat = 0) -> Self {
        return addAndPinAsSubview(of: view, horizontalPadding: padding, verticalPadding: padding)
    }
    
    @discardableResult
    func addAndPinAsSubview(of view: UIView, horizontalPadding padding: CGFloat = 0, verticalPadding vPadding: CGFloat = 0) -> Self {
        constrained()
            .addAsSubview(of: view)
            .pin(to: view, horizontalPadding: padding, verticalPadding: vPadding)
        return self
    }
    
    @discardableResult
    func addAndPinAsSubview(to view: UIView, leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        constrained()
            .addAsSubview(of: view)
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        return self
    }
    
    @discardableResult
    func pin(to view: UILayoutGuide, leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        return self
    }
    
    @discardableResult
    func pin(to view: UIView, leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        return self
    }
    
    @discardableResult
    func pin(to view: UIView, horizontalPadding padding: CGFloat = 0, verticalPadding vPadding: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: vPadding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -vPadding).isActive = true
        return self
    }
    
    @discardableResult
    func centered(inView: UIView? = nil) -> Self {
        let superView: UIView
        if let inView = inView {
            superView = inView
        } else {
            guard let superview = superview else { return self }
            superView = superview
        }
        
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        return self
    }
    
    
    @discardableResult
    func dimensions(width theWidth: CGFloat, height theHeight: CGFloat?) -> Self {
        width(theWidth)
        if let theHeight = theHeight {
            height(theHeight)
        } else {
            heightToWidth()
        }
        return self
    }
    
    @discardableResult
    func rounded(radius: CGFloat = 8) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult///Constrain the heightAnchor to the widthAnchor of the same view
    func heightToWidth() -> Self {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        return self
    }
    
    @discardableResult
    func width(equalsTo view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func width(percentFromSuperview multiplier: CGFloat = 1) -> Self {
        guard let superview = superview else { return self }
        return width(equalsTo: superview, multiplier: multiplier, constant: 0)
    }
    
    @discardableResult
    func height(percentFromSuperview multiplier: CGFloat = 1) -> Self {
        guard let superview = superview else { return self }
        return height(equalsTo: superview, multiplier: multiplier, constant: 0)
    }
    
    @discardableResult
    func height(equalsTo view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
}
