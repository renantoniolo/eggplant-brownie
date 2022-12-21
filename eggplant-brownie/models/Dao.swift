//
//  Dao.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 21/12/22.
//

import Foundation

class Dao {
    let mealsArchive: String = "meals"
    let itensArchive: String = "itens"
    
    func saveMeals(meals: [Meal]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(meals)
            UserDefaults.standard.set(data, forKey: mealsArchive)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func getMeals() -> [Meal] {
        if let data = UserDefaults.standard.data(forKey: mealsArchive) {
            do {
                let decoder = JSONDecoder()
                let meals = try decoder.decode([Meal].self, from: data)
                return meals
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return [Meal]()
    }
    
    func saveItens(itens: [Item]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(itens)
            UserDefaults.standard.set(data, forKey: itensArchive)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func getItens() -> [Item] {
        if let data = UserDefaults.standard.data(forKey: itensArchive) {
            do {
                let decoder = JSONDecoder()
                let meals = try decoder.decode([Item].self, from: data)
                return meals
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return [Item]()
    }
}
