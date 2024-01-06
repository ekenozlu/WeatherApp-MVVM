//
//  CustomForecastCardView.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class CustomForecastCardView : UIView {
    
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 18, weight: .light)
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
        backgroundColor = .clrSecondaryPurple
        layer.cornerRadius = 8
        
        addSubview(forecastImageView)
        addSubview(dateLabel)
        addSubview(degreeLabel)
        addSubview(windInfoView)
        addSubview(humidityInfoView)
        
        NSLayoutConstraint.activate([
            forecastImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            forecastImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            forecastImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            forecastImageView.widthAnchor.constraint(equalTo: forecastImageView.heightAnchor),
            
            dateLabel.leftAnchor.constraint(equalTo: forecastImageView.rightAnchor, constant: 8),
            dateLabel.topAnchor.constraint(equalTo: forecastImageView.topAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            degreeLabel.leftAnchor.constraint(equalTo: forecastImageView.rightAnchor, constant: 8),
            degreeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            degreeLabel.bottomAnchor.constraint(equalTo: forecastImageView.bottomAnchor),
            
            windInfoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            windInfoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            windInfoView.heightAnchor.constraint(equalToConstant: 32),
            windInfoView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            humidityInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            humidityInfoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            humidityInfoView.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            humidityInfoView.heightAnchor.constraint(equalToConstant: 32),
            humidityInfoView.topAnchor.constraint(equalTo: windInfoView.bottomAnchor, constant: 8)
        ])
    }
    
    public func setForecastAndView(forecast : Forecast){
        forecastImageView.image = UIImage(named: forecast.descriptionImageName)
        dateLabel.text = forecast.prettyDateString
        degreeLabel.text = "\(forecast.temperature)°C"
        windInfoView = InfoViewWithIcon(type: .wind, value: forecast.windSpeed)
        humidityInfoView = InfoViewWithIcon(type: .humidity, value: Double(forecast.humidity))
        setupView()
    }
    
    
    
}
