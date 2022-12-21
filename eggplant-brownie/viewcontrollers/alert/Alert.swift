//
//  Alert.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 20/12/22.
//

import Foundation
import UIKit

class Alert {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(message: String = "Unexpected error.") {
        let details = UIAlertController(title: "Sorry",
                                        message: message,
                                        preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Understood",
                                    style: .cancel,
                                    handler: nil)
        details.addAction(cancel)
        self.controller.present(details, animated: true, completion: nil)
    }
}
