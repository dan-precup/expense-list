//
//  HomeViewController.swift
//  JobGetTest
//
//  Created by Precup Aurel Dan on 12/01/2022.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private let loadingOverlay = LoadingOverlay()
    private let transactionCellId = "transactionCell"
    private let totalsCell = "totalsCell"
    private var transactions = [TransactionList]()
    private var bag = Set<AnyCancellable>()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(HomeTransactionCell.self, forCellReuseIdentifier: transactionCellId)
        table.register(HomeTotalsCell.self, forCellReuseIdentifier: totalsCell)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    init(viewModel: HomeViewModel) {
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
        view.background(.systemGroupedBackground)
        tableView.addAndPinAsSubview(of: view)
        loadingOverlay.addAsSubview(of: view)
        title = "Transactions"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didSelectCreateEntry))
    }
    
    private func setupBindings() {
        viewModel.transactions
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newTrasactions in
                guard let self = self else { return }
                self.transactions = newTrasactions
                UIView.transition(with: self.tableView, duration: 0.3, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() })
            }).store(in: &bag)
        loadingOverlay.bindLoadingAnimator(viewModel, storedIn: &bag)
    }
    
    @objc private func didSelectCreateEntry() {
        viewModel.didSelectCreateEntry()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        transactions.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return transactions[safe: section - 1]?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0, let list = transactions[safe: section - 1] else { return nil }
        return UILabel.body(list.date.dayPrettyString, size: 14, color: .secondaryLabel).wrapAndPin(padding: UIConstants.spacingDouble)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: totalsCell, for: indexPath) as? HomeTotalsCell
            cell?.setData(totalIncome: viewModel.incomes, totalExpenses: abs(viewModel.expenses), balance: viewModel.total)
            return cell ?? UITableViewCell()
        }
        
        
        guard let transaction = transactions[safe: indexPath.section - 1]?.transactions[safe: indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellId, for: indexPath) as? HomeTransactionCell
        else { return UITableViewCell() }
        
        cell.setTransaction(transaction)
        return cell
    }
}
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section > 0, let transaction = transactions[safe: indexPath.section - 1]?.transactions[indexPath.row] else { return nil }
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] ( _, _, completionHandler) in
                self?.viewModel.deleteEntry(transaction)
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}
