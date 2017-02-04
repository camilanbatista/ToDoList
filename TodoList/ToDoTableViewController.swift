//
//  ToDoTableViewController.swift
//  TodoList
//
//  Created by ios on 04/02/17.
//  Copyright © 2017 com.fa7. All rights reserved.
//

import UIKit
import Firebase

class ToDoTableViewController: UITableViewController {
    
    var items:[ToDoItem] = [ToDoItem]()

    @IBAction func signout(_ sender: UIBarButtonItem) {
        let firebaseAuth = FIRAuth.auth()
        do{
            try firebaseAuth?.signOut()
            self.dismiss(animated: true, completion: nil)
        }catch let signOutError as  NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        
        let item = self.items[indexPath.row]
        
        cell.textLabel?.text = item.nome!
        cell.detailTextLabel?.text = item.nome!
        
        return cell
    }
    
    @IBAction func unwindToMealList(segue:UIStoryboardSegue){
        if(segue.identifier == "add"){
            if let svc = segue.source as? ToDoItemViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    self.items[indexPath.row] = svc.item!
                }else{
                    self.items.append(svc.item!)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "edit"){
            if let dvc = segue.destination as? ToDoItemViewController{
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                let selectedItem = self.items[indexPath!.row]
                dvc.item = selectedItem
            }
        }
    }
    

}
