//
//  DetailVC.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit
import MapKit

class DetailVC: UIViewController, DetailViewModelProtocol {
    
    private var viewModel : DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var weatherCardView : CustomWeatherCardView!
    
    private lazy var favButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .clrSecondaryPurple
        button.addTarget(self, action: #selector(favTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .clrSecondaryPurple
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forecastTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Future Forecasts"
        label.textColor = .clrBlack
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private var forecastCardView1 : CustomForecastCardView!
    private var forecastCardView2 : CustomForecastCardView!
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isUserInteractionEnabled = false
        map.layer.cornerRadius = 8
        map.mapType = .mutedStandard
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        self.navigationItem.largeTitleDisplayMode = .never
        viewModel.getWeatherDetails()
        viewModel.checkForButtonStatus()
    }
    
    private func setupView() {
        view.backgroundColor = .clrWhite
        
        weatherCardView = CustomWeatherCardView()
        view.addSubview(weatherCardView)
        
        view.addSubview(favButton)
        view.addSubview(shareButton)
        
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .clrLightPink
        bottomView.layer.cornerRadius = 16
        view.addSubview(bottomView)
        
        bottomView.addSubview(forecastTitleLabel)
        
        forecastCardView1 = CustomForecastCardView()
        forecastCardView2 = CustomForecastCardView()
        bottomView.addSubview(forecastCardView1)
        bottomView.addSubview(forecastCardView2)
        
        bottomView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            weatherCardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            weatherCardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            weatherCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            favButton.topAnchor.constraint(equalTo: weatherCardView.topAnchor, constant: 8),
            favButton.rightAnchor.constraint(equalTo: weatherCardView.rightAnchor, constant: -8),
            favButton.widthAnchor.constraint(equalToConstant: 40),
            favButton.heightAnchor.constraint(equalToConstant: 40),
            
            shareButton.topAnchor.constraint(equalTo: favButton.topAnchor),
            shareButton.rightAnchor.constraint(equalTo: favButton.leftAnchor, constant: -8),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            bottomView.topAnchor.constraint(equalTo: weatherCardView.bottomAnchor, constant: -16),
            
            forecastTitleLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 8),
            forecastTitleLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -8),
            forecastTitleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            forecastTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            forecastCardView1.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 8),
            forecastCardView1.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -8),
            forecastCardView1.topAnchor.constraint(equalTo: forecastTitleLabel.bottomAnchor, constant: 8),
            
            forecastCardView2.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 8),
            forecastCardView2.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -8),
            forecastCardView2.topAnchor.constraint(equalTo: forecastCardView1.bottomAnchor, constant: 8),
            
            mapView.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 8),
            mapView.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -8),
            mapView.topAnchor.constraint(equalTo: forecastCardView2.bottomAnchor, constant: 16),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setButton(selected bool: Bool) {
        if bool {
            favButton.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            favButton.isSelected = true
        } else {
            favButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            favButton.isSelected = false
        }
    }
    
    func updateWeatherInformation(weather: Weather) {
        DispatchQueue.main.async { [self] in
            weatherCardView.setWeatherAndView(weather: weather)
            forecastCardView1.setForecastAndView(forecast: viewModel.selectedWeather.forecast[0])
            forecastCardView2.setForecastAndView(forecast: viewModel.selectedWeather.forecast[1])
            let initialCoordinate = CLLocationCoordinate2D(latitude: viewModel.selectedWeather.latitude,
                                                           longitude: viewModel.selectedWeather.longitude)
            let region = MKCoordinateRegion(center: initialCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: false)
        }
    }
    
    func showFetchError() {
        AlertManager.shared.showAlert(in: self, title: "Unable to fetch details right now.", message: "Please try again later", btnText: "Ok")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func favTapped(_ sender : UIButton) {
        if sender.isSelected {
            viewModel.removeWeatherFromeFavs()
        } else {
            viewModel.addWeatherToFavs()
        }
        sender.isSelected.toggle()
    }
    
    @objc func shareTapped() {
        let objects = ["Check out the weather of \(viewModel.selectedWeather.city)",
                       "It's \(viewModel.selectedWeather.temperature) degrees and \(viewModel.selectedWeather.weatherDescription.rawValue)"]
        let activityViewController = UIActivityViewController(activityItems: objects, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
