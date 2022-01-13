//
//  JGDropDown.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

protocol JGDropDownDelegate: AnyObject {
    func dropDown(_ dropdown: JGDropDown, didSelectOption atIndex: Int)
}

final class JGDropDown: UIView {
    weak var delegate: JGDropDownDelegate?
    private let options: [String]
    private let title: String
    private let titleLabel = UILabel.body(color: .label)
    private let chevronImage = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
    private let buttonOverlay = UIButton()
    
    init(options: [String], title: String) {
        self.title = options[safe: 0] ?? title
        self.options = options
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = title
        chevronImage.tinted(.label)
            .dimensions(width: UIConstants.interactionIcon, height: UIConstants.interactionIcon)
        let imageWrapper = chevronImage.wrapAndCenterKeepingDimensions()
            .minHeight(UIConstants.interactionIcon)
            .width(UIConstants.interactionIcon)
        [titleLabel, imageWrapper]
            .hStack()
            .addAndPinAsSubview(to: self, bottom: -UIConstants.spacing)
            .height(UIConstants.inputHeight)
            .underlined()
        
        buttonOverlay.addAndPinAsSubview(of: self)
        buttonOverlay.menu = makeMenu()
        buttonOverlay.showsMenuAsPrimaryAction = true


    }
    
    /// Build the menu
    /// - Returns: The UIMenu
    private func makeMenu() -> UIMenu  {
          let actions = options
            .enumerated()
            .map { index, title in
              return UIAction(
                title: title,
                identifier: UIAction.Identifier("\(index)"),
                handler: didSelectOption)
            }
          
          return UIMenu(
            title: title,
            options: .displayInline,
            children: actions)
    }
    
    
    /// Handle the option selection
    /// - Parameter action: The action that was selected
    private func didSelectOption(from action: UIAction) {
        guard let index = Int(action.identifier.rawValue) else {
          return
        }
        if let newTitle = options[safe: index] {
            titleLabel.text = newTitle
        }
        delegate?.dropDown(self, didSelectOption: index)
    }
    
}
