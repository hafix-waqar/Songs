//
//  Alert.swift
//  Practice App
//
//  Created by Hafiz Waqar Mustafa on 10/18/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    private static func action(title: String) -> UIAlertAction {
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if title == "Ok" { return okAction }
        if title == "No" { return noAction }
        else { return cancelAction }
    }
    
    static func ok(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action(title: "Ok"))
        return alert
    }
    
    static func yesAndNo(title: String, message: String, actionHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: actionHandler)
        alert.addAction(yesAction)
        alert.addAction(action(title: "No"))
        return alert
    }
    
    static func customAndCancel(title: String, message: String, actionTitle: String, actionHandler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let customAction = UIAlertAction(title: actionTitle, style: .destructive, handler: actionHandler)
        alert.addAction(customAction)
        alert.addAction(action(title: "Cancel"))
        return alert
    }
    
    static func customCancelAndTextfield(title: String, message: String, textFieldConfiguration: @escaping (UITextField) -> Void) -> UIAlertController {
        let alert = UIAlertController( title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: textFieldConfiguration)
        return alert
    }
    
    static func addActionsInTextFieldAlert(alert: UIAlertController, actionTitle: String, actionHandler: Optional<(UIAlertAction) -> Void>) {
        let customAction = UIAlertAction(title: actionTitle, style: .destructive, handler: actionHandler)
        alert.addAction(customAction)
        alert.addAction(action(title: "Cancel"))
    }
    
    
    
    
}
