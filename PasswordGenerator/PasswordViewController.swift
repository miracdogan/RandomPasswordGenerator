//
//  PasswordViewController.swift
//  PasswordGenerator
//
//  Created by Miraç Doğan on 5.11.2022.
//

import UIKit
import CoreData

class PasswordViewController: UITableViewController {
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwordList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listItem") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = passwordList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.passwordList.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    @IBOutlet weak var shoppingTableView: UITableView!
    
    var passwordList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItems()
    }

    func createItem(listItem: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PasswordModel", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(listItem, forKey: "item")
        do{
            try managedContext.save()
        } catch let error{
            print("Item can't be created: \(error.localizedDescription)")
        }
    }

    func fetchItems(){
        passwordList.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PasswordModel")
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for item in fetchResults as! [NSManagedObject]{
                passwordList.append(item.value(forKey: "item") as! String)
            }
            shoppingTableView.reloadData()
            
        } catch let error{
            print(error.localizedDescription)
        }
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Password", message: "Create your new password!", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.text = UIPasteboard.general.string
        }
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            self.createItem(listItem: alertController.textFields?.first?.text ?? "Error")
            self.fetchItems()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
