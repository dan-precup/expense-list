//
//  HomeTotalsCell.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 13/01/2022.
//

import UIKit

final class HomeTotalsCell: UITableViewCell {
    private struct Constants {
        static let expensesLabelTitle = "Expenses"
        static let incomeLabelTitle = "Income"
        static let balanceLabelTitle = "Balance"
        static let progressViewHeight: CGFloat = 5
        static let expensesRatioFontSize: CGFloat = 13
        static let expensesRatioDescrTemplate = "Your expenses used up %.2f%% of your income"
    }
    private lazy var expensesTitleLabel = makeLabel(text: Constants.expensesLabelTitle, isValueLabel: false)
    private lazy var expensesValueLabel = makeLabel(text: "$0.00", isValueLabel: true)
    private lazy var incomeTitleLabel = makeLabel(text: Constants.incomeLabelTitle, isValueLabel: false)
    private lazy var incomeValueLabel = makeLabel(text: "$0.00", isValueLabel: true)
    private lazy var balanceTitleLabel = makeLabel(text: Constants.balanceLabelTitle, isValueLabel: false)
    private lazy var balanceValueLabel = makeLabel(text: "$0.00", isValueLabel: true)
    private let progressView = UIProgressView()
    private let expensesRatioLabel = UILabel.make(size: Constants.expensesRatioFontSize, color: .secondaryLabel, numberOfLines: 1)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        let labelsStack = [
            [expensesTitleLabel, expensesValueLabel].vStack(),
            [incomeTitleLabel, incomeValueLabel].vStack(),
            [balanceTitleLabel, balanceValueLabel].vStack()
        ].hStack(distribution: .fillEqually)
        
        progressView.height(Constants.progressViewHeight)
        let progressVieWrapper = progressView.wrapAndPin(leading: UIConstants.spacingDouble, trailing: -UIConstants.spacingDouble)
        expensesRatioLabel.textCentered()
            .shrinkToFit()
        
        let mainStack = [
            labelsStack,
            expensesRatioLabel,
            progressVieWrapper,
            
        ]
            .vStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, padding: UIConstants.spacingDouble)
        mainStack.setCustomSpacing(UIConstants.spacing, after: expensesRatioLabel)
    }
    
    func setData(totalIncome: Double, totalExpenses: Double, balance: Double) {
        let expensesToIncomeRatio = totalIncome == 0 ? Float(1) : Float(totalExpenses / totalIncome)
        progressView.setProgress(expensesToIncomeRatio, animated: true)
        incomeValueLabel.text = totalIncome.asCurrency
        expensesValueLabel.text = totalExpenses.asCurrency
        balanceValueLabel.text = balance.asCurrency
        expensesRatioLabel.text = String(format: Constants.expensesRatioDescrTemplate, expensesToIncomeRatio * 100)

    }
    
    private func makeLabel(text: String = "", isValueLabel: Bool) -> UILabel {
        UILabel.make(text,
                     weight: isValueLabel ? .semibold : .regular,
                     size: 16,
                     color: isValueLabel ? .label : .secondaryLabel,
                     numberOfLines: 1)
            .textCentered().shrinkToFit()
    }
}
