//
//  CustomEmptyView.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class CustomEmptyView : UIView {
    
    private lazy var iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.tintColor = .clrGray
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrGray
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(icon : UIImage, title : String) {
        super.init(frame: .zero)
        iconImageView.image = icon
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clrWhite
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            iconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1),
            
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
    public func changeTitle(with text : String) {
        titleLabel.text = text
    }
    
    public func changeIcon(with image : UIImage) {
        iconImageView.image = image
    }
    
    
}
