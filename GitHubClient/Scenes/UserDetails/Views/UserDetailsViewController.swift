import UIKit

protocol UserDetailsViewControllerProtocol where Self: UIViewController {}

final class UserDetailsViewController: BaseViewController {
    // MARK: - Constants
    
    let cornerRadius: CGFloat = 16
    
    // MARK: - Subviews
    
    private lazy var userView: CardView = {
        let viewModel = CardViewModel(user: viewModel.user)
        return CardView(with: viewModel, isFullSize: true)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.backgroundView = spinner
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.refreshControl?.tintColor = .white
        tableView.refreshControl?.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private var isLoading = false
    
    // MARK: - Properties
    
    var viewModel: UserDetailsViewModelProtocol
    var repositoryList: [RepositoryModel] = []
    
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
        loadRepositoryList(from: viewModel.username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    // MARK: - Private Methods
    
    private func setupConstraints() {
        view.addSubview(userView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Space.base08),
            userView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Space.base04),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.base04),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        title = viewModel.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func loadRepositoryList(from username: String) {
        isLoading = true
        viewModel.loadRepositories(from: username) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let repositoryList):
                DispatchQueue.main.async {
                    self.repositoryList = repositoryList
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                    self.isLoading = false
                }
            case .failure(let error):
                self.isLoading = false
                self.showAlert(with: self.viewModel.errorAlertTitle,
                               message: error.localizedDescription,
                               andButtonTitle: self.viewModel.okButtonTitle)
            }
        }
    }
    
    @objc
    private func pulledToRefresh() {
        loadRepositoryList(from: viewModel.username)
    }
}

extension UserDetailsViewController: UserDetailsViewControllerProtocol {}

// MARK: - TableView

extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        let repository = repositoryList[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        if let description = repository.description {
            cell.textLabel?.text = description
        } else {
            cell.textLabel?.text = repository.name
        }
        
        return cell
    }
}
