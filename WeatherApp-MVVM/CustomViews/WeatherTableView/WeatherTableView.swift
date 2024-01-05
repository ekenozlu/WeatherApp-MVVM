//
//  WeatherTableView.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 5.01.2024.
//

import UIKit

final class WeatherTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.cellIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clrWhite
        self.rowHeight = 140
        self.separatorStyle = .none
        self.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 40, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
