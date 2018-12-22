//
//  UIViewController + alert.swift
//  Local Notiﬁcations
//
//  Created by Evgeniy Ryshkov on 22/12/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit
extension UIViewController {
    /**
     Present a simple alert to the user with an OK button to dismiss.
     - Parameter title: The title of the alert controller
     - Parameter message: The message for the alert controller
     - Parameter dismissTitle: The title of the dismiss button; defaults to "OK"
     */
    func alert(title: String? = nil, message: String? = nil, dismissTitle: String? = "OK") {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: dismissTitle, style: .default, handler: nil))
        present(ac, animated: true)
    }
}
