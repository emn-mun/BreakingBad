//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import UIKit

final class CharacterListViewController: UIViewController {
    private let presenter: CharacterListPresentable
    private let tableView = UITableView(frame: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var characters: [CharacterModel] = []
    private var filteredCharacters: [CharacterModel] = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    init(presenter: CharacterListPresentable) {
        self.presenter = presenter
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
        
        presenter.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.reusableIdentifier) as! CharacterListCell
        let character = characterFor(indexPath)
        
        cell.set(image: character.imageURLString, characterName: character.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacters.count
        }
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCharacterDetails(character: characterFor(indexPath))
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
        let category = CharacterModel.Season(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, season: category)
    }
    
    func filterContentForSearchText(_ searchText: String, season: CharacterModel.Season? = nil) {
        filteredCharacters = characters.filter { (character: CharacterModel) -> Bool in
            guard let seasons = character.appearance else { return false }
            let formattedSeason = seasons.map { "S\($0)" }
            
            let doesCategoryMatch = season == .all || formattedSeason.contains(season?.rawValue ?? "")
            
            if isSearchBarEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && character.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let season = CharacterModel.Season(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, season: season)
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.reusableIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = CharacterModel.Season.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
    }
    
    func characterFor(_ indexPath: IndexPath) -> CharacterModel {
        if isFiltering {
            return filteredCharacters[indexPath.row]
        } else {
            return characters[indexPath.row]
        }
    }
}
