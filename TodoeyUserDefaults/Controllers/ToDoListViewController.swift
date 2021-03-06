//
//  ViewController.swift
//  TodoeyUserDefaults
//
//  Created by Kajal on 1/9/18.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    //var itemArray = ["kajal","kiran","padhy"]
    var itemArray = [Item]()
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "kajal"
        itemArray.append(newItem)
        //loaded data from user defaults
//      if  let items = defaults.array(forKey: "ToDoItemCell") as? [Item]
//      {
//        itemArray = items
//       }
        
        loadData()
    }
    //MARK:- TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
 //MARK:- TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //tableView.reloadData()
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//MARK:- Add new Item in List

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         var textField = UITextField()
        let alert = UIAlertController(title: "ADD NEW ITEM IN TODOEY", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD NEW ITEM", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
          // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
          //  self.tableView.reloadData()
            self.saveData()
        }
      //adding text field to alert dialuge box
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create a new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Manipulation data
    func saveData()
    {
      let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
        }
        catch{
            print(error)
        }
        tableView.reloadData()
    }
     func loadData()
     {
        if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do{
            itemArray =  try decoder.decode([Item].self, from: data)
            }
            catch {
                print(error)
            }
        }
    }
}


