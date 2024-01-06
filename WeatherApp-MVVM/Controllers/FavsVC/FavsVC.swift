//
//  FavsVC.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

class FavsVC: UIViewController, FavsViewModelProtocol {
    internal let viewModel : FavsViewModel
    
    init(viewModel: FavsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var emptyView : CustomEmptyView!
    
    internal lazy var refreshControl : UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .clrSecondaryPurple
        return rc
    }()
    
    internal lazy var favsTV = WeatherTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchFavsFromCoreData()
    }
    
    private func setupNavigationBar() {
        self.title = "Favs"
        self.navigationItem.title = "Your Favourites"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        self.view.backgroundColor = .clrWhite
        
        emptyView = CustomEmptyView(icon: UIImage(systemName: "star.slash")!.withRenderingMode(.alwaysTemplate),
                                    title: "")
        self.view.addSubview(emptyView)
        
        favsTV.dataSource = self
        favsTV.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        favsTV.refreshControl = refreshControl
        self.view.addSubview(favsTV)
        
        NSLayoutConstraint.activate([
            emptyView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            emptyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            emptyView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            favsTV.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            favsTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            favsTV.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            favsTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateFavsTV() {
        DispatchQueue.main.async {
            self.favsTV.isHidden = false
            self.emptyView.isHidden = true
            self.favsTV.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func showUnableToFetchView() {
        DispatchQueue.main.async {
            self.favsTV.isHidden = true
            self.emptyView.isHidden = false
            self.emptyView.changeTitle(with: "Unable to reach your favourites.\nPlease check later")
        }
    }
    
    func showNoFavsView() {
        DispatchQueue.main.async {
            self.favsTV.isHidden = true
            self.emptyView.isHidden = false
            self.emptyView.changeTitle(with: "You don't have any favourites yet.\nAdd your first from details page")
        }
    }
}
