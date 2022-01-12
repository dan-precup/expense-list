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
        
        transactionTypeDropDown.delegate = viewModel
        
        let amountView = [
            amountTextfield,
            amountStepper.wrapAndPinToBottom()
        ].hStack()
        
        amountStepper.addTarget(self, action: #selector(didChangeStepperAmount), for: .valueChanged)
        amountStepper.maximumValue = Double.greatestFiniteMagnitude
        amountStepper.minimumValue = -Double.greatestFiniteMagnitude

        [titleLabel, transactionTypeDropDown, transactionDescriptionTextfield, amountView, addButton].vStack(spacing: UIConstants.spacingDouble)
            .addAndPinAsSubview(of: contentView, padding: UIConstants.spacingDouble)
        
        amountTextfield.setLeftViewText("$")
        amountTextfield.textField.keyboardType = .decimalPad
        amountTextfield.textField.delegate = self

        transactionDescriptionTextfield.textField.delegate = self
        transactionDescriptionTextfield.textField.addTarget(self, action: #selector(didChangeDescription), for: .editingChanged)
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
    
    @objc private func didChangeDescription() {
        viewModel.didChangeDescription(to: transactionDescriptionTextfield.textField.text)
    }
    
    @objc private func didChangeStepperAmount() {
        viewModel.didChangeStepperAmount(to: amountStepper.value)
        amountTextfield.textField.text = viewModel.transactionAmount.value.asString
    }

}

extension AddEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == transactionDescriptionTextfield.textField {
            amountTextfield.textField.becomeFirstResponder()
        }
        return true
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == amountTextfield.textField else { return true }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        //Ensuring that we only have 2 digits after the decimal point
        let components = updatedText.components(separatedBy: ".")
        let shouldApplyChanges = components.count > 1 ? components[1].count <= 2 : true
        if shouldApplyChanges {
            viewModel.didChangeAmount(to: updatedText)
        }
        return shouldApplyChanges
    }
}

