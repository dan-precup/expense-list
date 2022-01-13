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
        static let expensesOverflowRatioDescrTemplate = "Your expenses are greater than your income."
        static let cleanSlateDescr = "Clean slate - no expenses, no problems."

    }
    private lazy var expensesTitleLabel = makeLabel(text: Constants.expensesLabelTitle, isValueLabel: false, identifier: "expensesTitleLabel")
    private lazy var expensesValueLabel = makeLabel(text: "$0.00", isValueLabel: true, identifier: "expensesValueLabel")
    private lazy var incomeTitleLabel = makeLabel(text: Constants.incomeLabelTitle, isValueLabel: false, identifier: "incomeTitleLabel")
    private lazy var incomeValueLabel = makeLabel(text: "$0.00", isValueLabel: true, identifier: "incomeValueLabel")
    private lazy var balanceTitleLabel = makeLabel(text: Constants.balanceLabelTitle, isValueLabel: false, identifier: "balanceTitleLabel")
    private lazy var balanceValueLabel = makeLabel(text: "$0.00", isValueLabel: true, identifier: "balanceValueLabel")
    private let progressView = UIProgressView().identifier("progressView")
    private let expensesRatioLabel = UILabel.make(size: Constants.expensesRatioFontSize, color: .secondaryLabel, numberOfLines: 2).identifier("expensesRatioLabel")

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
        expensesRatioLabel.textCentered()
            .shrinkToFit()
        
        let mainStack = [
            labelsStack,
            expensesRatioLabel,
            progressView.wrapAndPin(leading: UIConstants.spacingDouble, trailing: -UIConstants.spacingDouble)
        ]
            .vStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, padding: UIConstants.spacingDouble)
        mainStack.setCustomSpacing(UIConstants.spacing, after: expensesRatioLabel)
    }
    
    /// Set the cell data
    /// - Parameters:
    ///   - totalIncome: Total income
    ///   - totalExpenses: Total expenses
    ///   - balance: The current balance
    func setData(totalIncome: Double, totalExpenses: Double, balance: Double) {
        let expensesToIncomeRatio = totalIncome == 0 ? Float(0) : min(1, Float(totalExpenses / totalIncome))
        progressView.setProgress(expensesToIncomeRatio, animated: true)
        progressView.progressTintColor = getGetTintColor(for: expensesToIncomeRatio)
        
        incomeValueLabel.text = totalIncome.asCurrency
        expensesValueLabel.text = totalExpenses.asCurrency
        balanceValueLabel.text = balance.asCurrency
        expensesRatioLabel.text = getExpensesRatioText(totalIncome: totalIncome, totalExpenses: totalExpenses, expensesToIncomeRatio: expensesToIncomeRatio)
    }
    
    /// Compute the progress view description text
    /// - Parameters:
    ///   - totalIncome: Total income
    ///   - totalExpenses: Total expenses
    ///   - expensesToIncomeRatio: Expenses to income ratio
    /// - Returns: The string
    private func getExpensesRatioText(totalIncome: Double, totalExpenses: Double, expensesToIncomeRatio: Float) -> String {
        guard totalExpenses > 0 else {
            return Constants.cleanSlateDescr
        }
        
        return totalIncome < totalExpenses ? Constants.expensesOverflowRatioDescrTemplate
        : String(format: Constants.expensesRatioDescrTemplate, expensesToIncomeRatio * 100)
    }
    
    /// Gets a tint color based on a given value from 0 to 1
    /// - Parameter expensesToIncomeRatio: The value
    /// - Returns: The tint color
    private func getGetTintColor(for expensesToIncomeRatio: Float) -> UIColor {
        if (0.8...0.9).contains(expensesToIncomeRatio) {
            return .systemOrange
        } else if expensesToIncomeRatio > 0.9 {
            return .systemRed
        }
        
        return .systemGreen
    }
    
    /// Create a label
    /// - Parameters:
    ///   - text: The text if any
    ///   - isValueLabel: If it's a amount label
    ///   - identififer: The string id
    /// - Returns: The label
    private func makeLabel(text: String = "", isValueLabel: Bool, identifier: String) -> UILabel {
        UILabel.make(text,
                     weight: isValueLabel ? .semibold : .regular,
                     size: 16,
                     color: isValueLabel ? .label : .secondaryLabel,
                     numberOfLines: 1)
            .textCentered()
            .shrinkToFit()
            .identifier(identifier)
    }
}
