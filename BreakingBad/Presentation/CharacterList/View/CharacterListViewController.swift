//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

final class CharacterListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: CharacterListViewModelling
  
    private let tableView = UITableView(frame: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(presenter: CharacterListViewModelling) {
        self.viewModel = presenter
        super.init(nibName: nil, bundle: nil)
        
        setupTableView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        viewModel.filteredCharacters
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CharacterListCell.reusableIdentifier)) { _, model, cell in
                if let cell = cell as? CharacterListCell {
                    cell.set(image: model.imageURLString, characterName: model.name)
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: false)
            self?.viewModel.itemSelectedIndex.onNext(indexPath)
        })
        .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.bind(to: viewModel.searchTextObserver)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.selectedScopeButtonIndex.bind(to: viewModel.selectedSeasonIndex)
            .disposed(by: disposeBag)
    }
}

private extension CharacterListViewController {
    func setupTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.reusableIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = viewModel.allSeasonNames
    }
}
