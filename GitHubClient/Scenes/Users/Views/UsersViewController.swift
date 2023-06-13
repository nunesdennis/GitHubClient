import UIKit

protocol UsersViewControllerProtocol where Self: UIViewController {}

final class UsersViewController: BaseViewController {
    // MARK: - Constants
    
    let cellRowHeight: CGFloat = 68
    let searchMinCharacters = 3
    
    // MARK: - Subviews
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = cellRowHeight
        tableView.register(UserCell.self, forCellReuseIdentifier: String(describing: UserCell.self))
        tableView.backgroundView = spinner
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .white
        tableView.refreshControl?.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private var isLoading = false
    
    // MARK: - Properties
    
    var cardsViewModel: [CardViewModel] = []
    var viewModel: UsersViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: UsersViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .paleTurquoise
        setupLargeCentralSpinner()
        setupSearch()
        setupConstraints()
        loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    // MARK: - Private Methods

    private func setupSearch() {
        shouldShowSearchBarButton(true)
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func setupNavigation() {
        title = viewModel.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadUsers(with username: String? = nil) {
        isLoading = true
        viewModel.loadUsers(with: username) { [unowned self] result in
            switch result {
            case .success(let cardViewModelList):
                cardsViewModel = cardViewModelList
                DispatchQueue.main.async { [unowned self] in
                    tableView.refreshControl?.endRefreshing()
                    tableView.reloadData()
                    spinner.stopAnimating()
                    isLoading = false
                }
            case .failure(let error):
                isLoading = false
                showAlert(with: viewModel.errorAlertTitle,
                          message: error.localizedDescription,
                          andButtonTitle: viewModel.okButtonTitle)
            }
        }
    }
    
    private func shouldShowSearchBarButton(_ shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(showSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func shouldShowSearch(_ shouldShow: Bool) {
        shouldShowSearchBarButton(!shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    @objc
    private func pulledToRefresh() {
        loadUsers()
    }
    
    @objc
    private func showSearchBar() {
        shouldShowSearch(true)
        searchBar.becomeFirstResponder()
    }
}

extension UsersViewController: UsersViewControllerProtocol {}

// MARK: - TableView

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        
        let cardViewModel = cardsViewModel[indexPath.row]
        cell.setupView(with: cardViewModel)
        
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardViewModel = cardsViewModel[indexPath.row]
        let user = cardViewModel.user
        viewModel.openDetails(of: user)
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              searchText.count > searchMinCharacters else {
            return
        }
        loadUsers(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearch(false)
        loadUsers()
    }
}
