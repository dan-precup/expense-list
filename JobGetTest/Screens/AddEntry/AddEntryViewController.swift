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
        static let transactionDescriptionPlaceholder = "e.g.: Apple store - new iphone"
        static let transactionDescriptionTitle = "Transaction description"
        static let amountTitle = "Amount"
        static let amountPlaceholder = "100.0"
        static let transactionTypeTitle = "Transaction Type"
    }
    private var bag = Set<AnyCancellable>()
    private let viewModel: AddEntryViewModel
    private let contentView = UIView()
    private let transactionDescriptionTextfield = TitltedTextField(title: Constants.transactionDescriptionTitle, placeholder: Constants.transactionDescriptionPlaceholder)
    private let amountTextfield = TitltedTextField(title: Constants.amountTitle, placeholder: Constants.amountPlaceholder)
    private let titleLabel = UILabel.title(Constants.titleString)
    private let addButton = UIButton(configuration: .filled(), primaryAction: nil)
    private let amountStepper = UIStepper()
    private let closeButton = UIButton()

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
        setupContentView()

        addButton.setTitle(Constants.addButtonString, for: .normal)
        addButton.addTarget(self, action: #selector(didSelectAdd), for: .touchUpInside)
        
        transactionTypeDropDown.delegate = viewModel
        
        [titleLabel, transactionTypeDropDown, transactionDescriptionTextfield, setupAmountFields(), addButton]
            .vStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, padding: UIConstants.spacingDouble)

        transactionDescriptionTextfield.textField.delegate = self
        transactionDescriptionTextfield.textField.addTarget(self, action: #selector(didChangeDescription), for: .editingChanged)

        setupCloseMethods()
    }
    
    /// Setup the content view container
    private func setupContentView() {
        contentView.addAsSubview(of: view)
            .constrained()
            .pinHorizontaly(to: view, padding: UIConstants.spacingDouble)
            .background(.systemBackground)
            .centerY(to: view)
            .rounded()
    }
    
    /// Setup the amount fields
    /// - Returns: A amount fields horizontal stack
    private func setupAmountFields() -> UIView {
        let amountView = [
            amountTextfield,
            amountStepper.wrapAndPinToBottom()
        ].hStack()
        
        amountStepper.addTarget(self, action: #selector(didChangeStepperAmount), for: .valueChanged)
        amountStepper.maximumValue = Double.greatestFiniteMagnitude
        amountStepper.minimumValue = -Double.greatestFiniteMagnitude
        amountTextfield.setLeftViewText("$")
        amountTextfield.textField.keyboardType = .decimalPad
        amountTextfield.textField.delegate = self
        return amountView
    }
    
    /// Prepare closing methods
    private func setupCloseMethods() {
        closeButton.addTarget(self, action: #selector(didSelectClose), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.addAsSubview(of: contentView)
            .constrained()
            .trailing(to: contentView, constant: -UIConstants.spacingDouble)
            .top(to: contentView, constant: UIConstants.spacingDouble)
            .tinted(.tertiaryLabel)
        let closeView = UIView()
        closeView.addAndPinAsSubview(of: view)
        view.sendSubviewToBack(closeView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectClose))
        closeView.addGestureRecognizer(tapGesture)
    }
    
    private func setupBindings() {
        viewModel.ctaEnabled.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isEnabled in
                self?.addButton.isEnabled = isEnabled
            }).store(in: &bag)
        
        viewModel.transactionAmount.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newAmount in
                self?.amountStepper.value = newAmount
            }).store(in: &bag)
    }
    
    /// Notify the VM amout a new value in the description textfield
    @objc private func didChangeDescription() {
        viewModel.didChangeDescription(to: transactionDescriptionTextfield.textField.text)
    }
    
    /// Notify the VM amout a new value in the amount stepper field
    @objc private func didChangeStepperAmount() {
        viewModel.didChangeStepperAmount(to: amountStepper.value)
        amountTextfield.textField.text = viewModel.transactionAmount.value.asString
    }
    
    /// Handle the CTA trigger
    @objc private func didSelectAdd() {
        viewModel.didSelectCreateEntity()
    }
    
    /// Handle the close event
    @objc private func didSelectClose() {
        viewModel.didSelectClose()
    }
}

// MARK: - UITextFieldDelegate implementation
extension AddEntryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Simple return focus change
        if textField == transactionDescriptionTextfield.textField {
            amountTextfield.textField.becomeFirstResponder()
        }
        return true
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == amountTextfield.textField else { return true }
        // Build the new string
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        // Ensure that we only have 2 digits after the decimal point
        let components = updatedText.components(separatedBy: ".")
        
        let shouldApplyChanges = components.count > 1 ? components[1].count <= 2 : true
        if shouldApplyChanges {
            //Only notify VM if we shoudl apply changes
            viewModel.didChangeAmount(to: updatedText)
        }
        return shouldApplyChanges
    }
}

