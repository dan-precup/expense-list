//
//  HomeTransactionCell.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit

final class HomeTransactionCell: UITableViewCell {
    private struct Constants {
        static let imageViewSide: CGFloat = 40
    }
    private let circleView = UIView()
    private let trasactionLetterLabel = UILabel.make(weight: .semibold, size: 25, color: .white, numberOfLines: 1).identifier("transactionLetterLabel")
    private let nameLabel = UILabel.make(weight: .semibold, size: 16).identifier("transactionNameLabel")
    private let amountLabel = UILabel.make(weight: .regular, size: 16).identifier("transactionAmountLabel")
    private let timeLabel = UILabel.make(size: 12, color: .secondaryLabel, numberOfLines: 1)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let circleWrapper = circleView.dimensions(width: Constants.imageViewSide, height: Constants.imageViewSide)
            .rounded(radius: Constants.imageViewSide / 2)
            .background(UIColor.pastels.randomElement()!)
            .wrapAndCenterKeepingDimensions()
            .width(Constants.imageViewSide)
            .minHeight(Constants.imageViewSide)
        
        amountLabel.align(.right)
        let nameAndAmountStack = [nameLabel, amountLabel].hStack()
        let labelsStack = [nameAndAmountStack, timeLabel].vStack().wrapAndPin(top: UIConstants.spacing, bottom: -UIConstants.spacing)
        
        [circleWrapper, labelsStack].hStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, horizontalPadding: UIConstants.spacingDouble, verticalPadding: UIConstants.spacing)
        trasactionLetterLabel.addAsSubview(of: contentView)
            .constrained()
            .centered(inView: circleWrapper)
        selectionStyle = .none
    }
    
    /// Set the transaction data in the respective outlets
    /// - Parameter transaction: The transaction
    func setTransaction(_ transaction: SingleTransaction) {
        nameLabel.text = transaction.name
        amountLabel.text = transaction.signedAmount.asCurrency
        timeLabel.text = transaction.date?.timeString
        if let firstLetter = transaction.name?.prefix(1) {
            trasactionLetterLabel.text = String(firstLetter)
        }
    }
}
