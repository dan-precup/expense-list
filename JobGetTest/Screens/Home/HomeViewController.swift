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
    private var transactions = [TransactionList]()
    private var bag = Set<AnyCancellable>()
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(HomeTransactionCell.self, forCellReuseIdentifier: transactionCellId)
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
                self?.transactions = newTrasactions
                self?.tableView.reloadData()
            }).store(in: &bag)
        loadingOverlay.bindLoadingAnimator(viewModel, storedIn: &bag)
    }
    
    @objc private func didSelectCreateEntry() {
        viewModel.didSelectCreateEntry()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions[safe: section]?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let list = transactions[safe: section] else { return nil }
        return UILabel.body(list.date.dayPrettyString, size: 14, color: .secondaryLabel).wrapAndPin(padding: UIConstants.spacingDouble)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transaction = transactions[safe: indexPath.section]?.transactions[safe: indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: transactionCellId, for: indexPath) as? HomeTransactionCell
        else { return UITableViewCell() }
        
        cell.setTransaction(transaction)
        return cell
    }
}
extension HomeViewController: UITableViewDelegate {}
