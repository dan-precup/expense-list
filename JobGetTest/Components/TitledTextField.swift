//
//  TitledTextField.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

final class TitltedTextField: UIView {
    private let titleLabel = UILabel.make(weight: .semibold, size: 10, numberOfLines: 1)
    let textField = UITextField()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        textField.placeholder = placeholder
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLeftViewText(_ text: String) {
        textField.leftView = UILabel.body(text)
        textField.leftViewMode = .always
    }
    
    private func setupUI() {
        [titleLabel,
         textField.height(UIConstants.inputHeight)]
            .vStack(spacing: UIConstants.spacingHalf)
            .underlined()
            .addAndPinAsSubview(of: self)
    }
}
