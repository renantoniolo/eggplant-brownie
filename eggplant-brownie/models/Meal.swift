//
//  Meal.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 04/12/22.
//

import Foundation

class Meal: Codable {
    let name: String
    let happiness: Int
    var items: [Item] = []
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }
    
    func allCalories() -> Double {
        var total = 0.0
        for i in items {
            total += i.calories
        }
        return total
    }
    
    func details() -> String {
        var message = "Happines: \(self.happiness)"
        items.forEach { Item in
            message += " \n \(Item.name) - calories: \(Item.calories)"
        }
        return message
    }
}
