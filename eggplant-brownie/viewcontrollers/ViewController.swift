//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 04/12/22.
//

import UIKit

protocol AddItemDelegate {
    func addNew(item: Item)
}

final class ViewController: UIViewController {
    var delegate: AddMealsDelegate?
    var selected: [Item] = []
    var itens: [Item] = []
    let dao: Dao = Dao()
    
    @IBOutlet weak private var nameField: UITextField!
    @IBOutlet weak private var happinessField: UITextField!
    @IBOutlet weak private var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itens = dao.getItens()
        let newItemButton = UIBarButtonItem(title: "new item",
                                            style: .plain,
                                            target: self,
                                            action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
        
    }
    
    @IBAction func add(_ sender: UIButton) {
        guard let name = nameField.text,
        let happiness = happinessField.text else {
            return
        }
        
        if name.isEmpty || happiness.isEmpty {
            Alert(controller: self).show(message: "Insira um nome e uma caloria para essa refeição.")
            return
        }
        
        let meal = Meal(name: name, happiness: (happiness as NSString).integerValue)
        meal.items =  selected
        
        if let _delegate = delegate {
            _delegate.add(meal: meal)
        }
        
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    @objc func showNewItem() {
        let newItemView = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItemView, animated: true)
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = itens[row]
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        if cell == nil {
            return
        }
        
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = .checkmark
            selected.append(itens[indexPath.row])
        } else {
            cell?.accessoryType = .none
            let itemSelected = itens[indexPath.row]
            var cont = 0
            let selectedAux = selected
            selectedAux.map { item_ in
                if (item_.name == itemSelected.name) {
                    selected.remove(at: cont)
                }
                cont = cont + 1
            }
        }
    }
}

extension ViewController : AddItemDelegate {
    func addNew(item: Item) {
        itens.append(item)
        dao.saveItens(itens: itens)
        guard let table = tableview else {
            Alert(controller: self).show()
            return
        }
        table.reloadData()
    }
}
