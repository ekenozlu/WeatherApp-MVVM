//
//  CustomWeatherCardView.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class CustomWeatherCardView : UIView {
    
    private lazy var countryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var cityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var degreeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var forecastImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private var windInfoView : InfoViewWithIcon!
    private var humidityInfoView : InfoViewWithIcon!
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clrMainPurple
        
        self.addSubview(forecastImageView)
        self.addSubview(countryLabel)
        self.addSubview(cityLabel)
        self.addSubview(degreeLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(windInfoView)
        self.addSubview(humidityInfoView)
        
        NSLayoutConstraint.activate([
            forecastImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            forecastImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            forecastImageView.heightAnchor.constraint(equalToConstant: 70),
            forecastImageView.widthAnchor.constraint(equalToConstant: 70),
            
            countryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            countryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4),
            countryLabel.topAnchor.constraint(equalTo: forecastImageView.bottomAnchor, constant: 8),
            countryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            cityLabel.leftAnchor.constraint(equalTo: countryLabel.leftAnchor),
            cityLabel.rightAnchor.constraint(equalTo: countryLabel.rightAnchor),
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 8),
            cityLabel.heightAnchor.constraint(equalToConstant: 25),
            
            degreeLabel.leftAnchor.constraint(equalTo: cityLabel.leftAnchor),
            degreeLabel.rightAnchor.constraint(equalTo: cityLabel.rightAnchor),
            degreeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            degreeLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.leftAnchor.constraint(equalTo: degreeLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: degreeLabel.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16),
            
            windInfoView.heightAnchor.constraint(equalToConstant: 32),
            windInfoView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            windInfoView.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            windInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            
            humidityInfoView.heightAnchor.constraint(equalToConstant: 32),
            humidityInfoView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            humidityInfoView.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 8),
            humidityInfoView.bottomAnchor.constraint(equalTo: windInfoView.bottomAnchor)
        ])
    }
    
    func setWeatherAndView(weather : Weather) {
        forecastImageView.image = UIImage(named: weather.descriptionImageName)
        countryLabel.text = weather.country
        cityLabel.text = weather.city
        degreeLabel.text = "\(weather.temperature)°C"
        descriptionLabel.text = weather.weatherDescription.rawValue
        windInfoView = InfoViewWithIcon(type: .wind, value: weather.windSpeed)
        humidityInfoView = InfoViewWithIcon(type: .humidity, value: Double(weather.humidity))
        setupView()
    }
    
    
    
}
