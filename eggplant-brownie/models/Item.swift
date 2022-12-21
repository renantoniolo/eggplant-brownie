//
//  Item.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 04/12/22.
//

import Foundation

final class Item: Codable {
    let name: String
    let calories: Double
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
}
