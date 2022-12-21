//
//  NewItemViewController.swift
//  eggplant-brownie
//
//  Created by Renan Toniolo Rocha on 11/12/22.
//

import UIKit

final class NewItemViewController : UIViewController {
    private var addItemDelegate: AddItemDelegate
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var caloriesField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(delegate: AddItemDelegate) {
        self.addItemDelegate = delegate
        super.init(nibName: "NewItemViewController",
                    bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func add(_ sender: UIButton) {
        if nameField.text!.isEmpty ||
            caloriesField.text!.isEmpty {
            Alert(controller: self).show(message: "Insira um nome e uma caloria para esse item.")
            return
        }
        
        guard let name = nameField.text else {
            return
        }
        
        if let calories = Double(caloriesField.text ?? String()) {
            let item = Item(name: name, calories: calories)
            addItemDelegate.addNew(item: item)
            
            if let navigation = navigationController {
                navigation.popViewController(animated: true)
            }
        } else {
            Alert(controller: self).show(message: "Calories não é um valor double.")
        }
    }
}
