//
//  AlertManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 6.01.2024.
//

import UIKit

final class AlertManager {
    
    public static let shared = AlertManager()
    
    private init() {}
    
    public func showAlert(in vc : UIViewController, title text : String, message subtext : String, btnText buttonText : String) {
        let alert = UIAlertController(title: text, message: subtext, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { action in
            alert.dismiss(animated: true)
        }))
        vc.present(alert, animated: true)
    }
}
