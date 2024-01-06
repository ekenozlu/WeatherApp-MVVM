//
//  CustomOfflineView.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 6.01.2024.
//

import UIKit

final class CustomOfflineView : UIView {
    
    private lazy var iconImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "network.slash")?.withRenderingMode(.alwaysTemplate)
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .clear
        imageview.tintColor = .clrLightPink
        return imageview
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clrLightPink
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(title : String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientToView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.8),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            
            iconImageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: -8),
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    public func changeTitle(with text : String) {
        titleLabel.text = text
    }
    
    private func addGradientToView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clrBlack.cgColor,UIColor.clear.cgColor]
                                gradientLayer.locations = [0.3, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
