//
//  InfoViewWithIcon.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

enum InfoType {
    case wind
    case humidity
}

final class InfoViewWithIcon : UIView {
    
    private lazy var iconImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .clrMainPurple
        return imageView
    }()
    
    private lazy var valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrMainPurple
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    init(type : InfoType, value : Double) {
        super.init(frame: .zero)
        iconImage.image = UIImage(systemName: type == .wind ? "wind" : "drop.fill")
        valueLabel.text = type == .wind ? "\(value)" : "%\(Int(value))"
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clrWhite
        layer.cornerRadius = 16
        
        addSubview(iconImage)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            iconImage.widthAnchor.constraint(equalTo: iconImage.heightAnchor),
            
            valueLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 8),
            valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])
    }
    
}
