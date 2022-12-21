//
//  RemoveMealController.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 21/12/22.
//

import Foundation
import UIKit

class RemoveMealController {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showMeal(meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        let detail = UIAlertController(title: meal.name,
                                       message: meal.details(),
                                       preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .default)
        detail.addAction(cancel)
        let remove = UIAlertAction(title: "Remove",
                                   style: .cancel, handler: handler)
        detail.addAction(remove)
        self.controller.present(detail, animated: true, completion: nil)
    }
}
