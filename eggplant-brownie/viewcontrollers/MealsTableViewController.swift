//
//  MealsTableViewController.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 04/12/22.
//

import UIKit

protocol AddMealsDelegate {
    func add(meal: Meal)
}

class MealsTableViewController : UITableViewController {
    private var meals: [Meal] = []
    private let dao: Dao = Dao()
    
    override func viewDidLoad() {
        self.meals = dao.getMeals()
    }
    
    @objc func showDetails(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            let cell = recognizer.view as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            if indexPath == nil {
                return
            }
            guard let row = indexPath?.row else {
                return
            }
            let meal = meals[row]
            RemoveMealController(controller: self).showMeal(meal: meal, handler: { action in
                self.meals.remove(at: row)
                self.dao.saveMeals(meals: self.meals)
                self.tableView.reloadData()
            } )
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        cell.addGestureRecognizer(longPress)
        cell.textLabel?.text = meal.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMeal" {
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }
}

extension MealsTableViewController : AddMealsDelegate {
    func add(meal: Meal) {
        meals.append(meal)
        dao.saveMeals(meals: meals)
        guard let table = tableView else {
            Alert(controller: self).show()
            return
        }
        table.reloadData()
    }
}
