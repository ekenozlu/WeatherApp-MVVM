//
//  AlertManager.swift
//  WeatherApp-MVVM
//
//  Created by Eken Özlü on 6.01.2024.
//

import UIKit

final class AlertManager {
    
    //MARK: - Singleton Object
    public static let shared = AlertManager()
    
    //MARK: - Initializer
    private init() {}
    
    ///This function presents a UIAlertController in given ViewController. Alert has a default button which dismiss the alert itself.
    ///
    ///> Parameters:
    ///> "in vc : UIViewController" should be the ViewController to show alert
    ///> "title text : String" should be title of the alert
    ///> "message subtext : String" should be the message of the alert
    ///> "btnText buttonText : String" should be the title of the button
    ///
    ///> Returns:
    ///> An alert in given VC.
    
    public func showAlert(in vc : UIViewController, title text : String, message subtext : String, btnText buttonText : String) {
        let alert = UIAlertController(title: text, message: subtext, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: { action in
            alert.dismiss(animated: true)
        }))
        vc.present(alert, animated: true)
    }
}
