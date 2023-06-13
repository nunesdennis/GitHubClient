import UIKit

protocol UserDetailsViewControllerProtocol where Self: UIViewController {}

final class UserDetailsViewController: BaseViewController {
    // MARK: - Constants
    
    let cellRowHeight: CGFloat = 68
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = cellRowHeight
//        tableView.register(UserCell.self, forCellReuseIdentifier: String(describing: UserCell.self))
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
    
    var viewModel: UserDetailsViewModelProtocol
    
    // MARK: - Initialization
    
    init(viewModel: UserDetailsViewModelProtocol) {
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
        setupConstraints()
        loadRepositories(from: viewModel.username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    // MARK: - Private Methods
    
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
    
    private func loadRepositories(from username: String) {
        isLoading = true
//        viewModel.loadUsers(with: username) { [unowned self] result in
//            switch result {
//            case .success(let cardViewModelList):
//                cardsViewModel = cardViewModelList
//                DispatchQueue.main.async { [unowned self] in
//                    tableView.refreshControl?.endRefreshing()
//                    tableView.reloadData()
//                    spinner.stopAnimating()
//                    isLoading = false
//                }
//            case .failure(let error):
//                isLoading = false
//                showAlert(with: viewModel.errorAlertTitle,
//                          message: error.localizedDescription,
//                          andButtonTitle: viewModel.okButtonTitle)
//            }
//        }
    }
    
    @objc
    private func pulledToRefresh() {
        loadRepositories(from: viewModel.username)
    }
}

extension UserDetailsViewController: UserDetailsViewControllerProtocol {}

// MARK: - TableView

extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell else {
//            return UITableViewCell()
//        }
//
//        let cardViewModel = cardsViewModel[indexPath.row]
//        cell.setupView(with: cardViewModel)
        
        return UITableViewCell()
    }
}

extension UserDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cardViewModel = cardsViewModel[indexPath.row]
//        let username = cardViewModel.getUsername()
//        viewModel.openDetails(of: match)
    }
}
