//
//  AddEntryViewController.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit
import Combine

final class AddEntryViewController: UIViewController {
    private struct Constants {
        static let titleString = "Add transaction"
        static let addButtonString = "Add"
        static let transactionDescriptionPlaceholder = "Transaction description"
        static let amountPlaceholder = "Amount"
        static let transactionTypeTitle = "Transaction Type"
    }
    private var bag = Set<AnyCancellable>()
    private let viewModel: AddEntryViewModel
    private let contentView = UIView()
    private let transactionDescriptionTextfield = UITextField()
    private let amountTextfield = UITextField()
    private let titleLabel = UILabel.title(Constants.titleString)
    private let addButton = UIButton(configuration: .filled(), primaryAction: nil)
    private lazy var transactionTypeDropDown = JGDropDown(options: viewModel.transactionTypeOptions, title: Constants.transactionTypeTitle)

    init(viewModel: AddEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.didFinishLoading()
    }
    
    private func setupUI() {
        view.background(.black.withAlphaComponent(0.4))
        contentView.addAsSubview(of: view)
            .constrained()
            .pinHorizontaly(to: view, padding: UIConstants.spacingDouble)
            .background(.systemBackground)
            .centerY(to: view)
            .rounded()
        
        addButton.setTitle(Constants.addButtonString, for: .normal)
        
        transactionDescriptionTextfield.underlined()
            .height(UIConstants.inputHeight)
        transactionDescriptionTextfield.placeholder = Constants.transactionDescriptionPlaceholder

        amountTextfield.underlined()
            .height(UIConstants.inputHeight)
        amountTextfield.placeholder = Constants.amountPlaceholder
        
        transactionTypeDropDown.delegate = viewModel
        
        [titleLabel, transactionTypeDropDown, transactionDescriptionTextfield, amountTextfield, addButton].vStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, padding: UIConstants.spacingDouble)
        
        amountTextfield.addTarget(self, action: #selector(didChangeAmount), for: .editingChanged)
        transactionDescriptionTextfield.addTarget(self, action: #selector(didChangeDescription), for: .editingChanged)
    }
    
    private func setupBindings() {
        viewModel.ctaEnabled.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isEnabled in
                self?.addButton.isEnabled = isEnabled
            }).store(in: &bag)
    }
    
    @objc private func didChangeAmount() {
        viewModel.didChangeAmount(to: amountTextfield.text)
    }
    @objc private func didChangeDescription() {
        viewModel.didChangeDescription(to: transactionDescriptionTextfield.text)
    }
}


