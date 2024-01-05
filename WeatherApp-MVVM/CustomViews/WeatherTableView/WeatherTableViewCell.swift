//
//  WeatherTableViewCell.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    
    //MARK: - Cell Identifier
    public static let cellIdentifier = "weatherCell"
    
    //MARK: - UI Elements
    public lazy var countryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var cityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var degreeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    public lazy var forecastImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    public lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrWhite
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupCellView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = .clrMainPurple
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 8
        contentView.addSubview(backView)
        
        let thermometerImage = UIImageView(image: UIImage(systemName: "thermometer.medium")?.withRenderingMode(.alwaysTemplate))
        thermometerImage.translatesAutoresizingMaskIntoConstraints = false
        thermometerImage.tintColor = .clrLightPink
        thermometerImage.contentMode = .scaleAspectFit
        
        backView.addSubview(countryLabel)
        backView.addSubview(cityLabel)
        backView.addSubview(thermometerImage)
        backView.addSubview(degreeLabel)
        backView.addSubview(forecastImageView)
        backView.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            countryLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 12),
            countryLabel.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.7),
            countryLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            countryLabel.heightAnchor.constraint(equalToConstant: 18),
            
            cityLabel.leftAnchor.constraint(equalTo: countryLabel.leftAnchor),
            cityLabel.rightAnchor.constraint(equalTo: countryLabel.rightAnchor),
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor,constant: 8),
            cityLabel.heightAnchor.constraint(equalToConstant: 25),
            
            thermometerImage.leftAnchor.constraint(equalTo: cityLabel.leftAnchor),
            thermometerImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,constant: 8),
            thermometerImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -8),
            thermometerImage.widthAnchor.constraint(equalToConstant: 20),
            
            degreeLabel.leftAnchor.constraint(equalTo: thermometerImage.rightAnchor,constant: 4),
            degreeLabel.topAnchor.constraint(equalTo: thermometerImage.topAnchor),
            degreeLabel.bottomAnchor.constraint(equalTo: thermometerImage.bottomAnchor),
            degreeLabel.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.5),
            
            forecastImageView.leftAnchor.constraint(equalTo: countryLabel.rightAnchor, constant: 12),
            forecastImageView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -12),
            forecastImageView.topAnchor.constraint(equalTo: countryLabel.topAnchor),
            forecastImageView.heightAnchor.constraint(equalTo: forecastImageView.widthAnchor),
            
            descriptionLabel.rightAnchor.constraint(equalTo: forecastImageView.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: forecastImageView.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8)
        ])
    }
    
}
