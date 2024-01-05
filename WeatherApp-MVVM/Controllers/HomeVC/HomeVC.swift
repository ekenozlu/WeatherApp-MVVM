//
//  ViewController.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class HomeVC: UIViewController, HomeViewModelDelegate {
    
    internal let viewModel : HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal lazy var searchController : UISearchController = {
       let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.searchTextField.textColor = .clrMainPurple
        sc.searchBar.searchTextField.placeholder = "Search For Place"
        sc.searchBar.tintColor = .clrMainPurple
        sc.searchBar.delegate = self
        return sc
    }()
    
    internal var emptyView : CustomEmptyView!
    
    internal lazy var weatherTV = WeatherTableView()
    
    internal lazy var loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.color = .clrMainPurple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        viewModel.fetchWeathers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.loadCheck = true
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "World Weather"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.searchController = searchController
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        weatherTV.dataSource = self
        weatherTV.delegate = self
        
        emptyView = CustomEmptyView(icon: UIImage(systemName: "cloud.rain")!.withRenderingMode(.alwaysTemplate), title: "")
        self.view.addSubview(emptyView)
        self.view.addSubview(weatherTV)
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            emptyView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            emptyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            emptyView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            weatherTV.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            weatherTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            weatherTV.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            weatherTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 20),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 20),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    func updateWeatherTV() {
        viewModel.reachedBottom = false
        DispatchQueue.main.async {
            self.weatherTV.isHidden = false
            self.emptyView.isHidden = true
            self.weatherTV.reloadData()
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
    }
    
    func showStartEmptyView() {
        DispatchQueue.main.async {
            self.weatherTV.isHidden = true
            self.emptyView.isHidden = false
            self.emptyView.changeTitle(with: "There is no weather forecast available.\nCheck your network.")
        }
    }
    
    func showSearchEmptyView() {
        DispatchQueue.main.async {
            self.weatherTV.isHidden = true
            self.emptyView.isHidden = false
            self.emptyView.changeTitle(with: "Sorry we couldn't find what you are looking for.\nTry another one.")
        }
    }
}
