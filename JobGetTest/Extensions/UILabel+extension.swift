//
//  UILabel+extension.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

extension UILabel {
    static func title(_ text: String = "", size: CGFloat = 24, color: UIColor = .label) -> UILabel {
        make(text, weight: .semibold, size: size, color: color)
    }

    static func body(_ text: String = "", size: CGFloat = 16, color: UIColor = .label) -> UILabel {
        make(text, weight: .regular, size: size, color: color)
    }
    
    static func make(_ text: String = "", weight: UIFont.Weight = .regular, size: CGFloat = 16, color: UIColor = .label, numberOfLines: Int = 0) -> UILabel {
        return UILabel(frame: .zero).text(text)
            .font(UIFont.systemFont(ofSize: size, weight: weight))
            .color(color)
            .lines(numberOfLines)
    }

    static func withStyle(_ text: String = "", textStyle: UIFont.TextStyle, color: UIColor = .label, numberOfLines: Int = 0) -> UILabel {
        return UILabel(frame: .zero).text(text)
            .textStyle(textStyle)
            .color(color)
            .lines(numberOfLines)
    }
    
    @discardableResult
    func shrinkToFit(minScale: CGFloat = 0.2) -> Self {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = minScale
        return self
    }
    
    @discardableResult
    func truncateToFit() -> Self {
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        return self
    }
    
    @discardableResult
    func lines(_ lines: Int) -> Self {
        numberOfLines = lines
        return self
    }

    @discardableResult
    func textCentered() -> Self {
        return align(.center)
    }

    @discardableResult
    func align(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }

    @discardableResult
    func textOrHide(_ text: String?) -> Self {
        self.text = text
        isHidden = text == nil
        return self
    }

    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func textStyle(_ style: UIFont.TextStyle) -> Self {
        return font(UIFont.preferredFont(forTextStyle: style))

    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

}
