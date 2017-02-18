//
//  ToDoTableViewController.swift
//  TodoList
//
//  Created by ios on 04/02/17.
//  Copyright © 2017 com.fa7. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ToDoTableViewController: UITableViewController {
    
    var items:[ToDoItem] = [ToDoItem]()

    var ref:FIRDatabaseReference!
    
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
        self.ref = FIRDatabase.database().reference()
        self.setupObservers()
    }

    func setupObservers(){
        self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).child("items").observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            print("----------START-----------")
            self.items.removeAll()
            for snapshotChild in snapshot.children{
                
                let child = snapshotChild as! FIRDataSnapshot
                let value = child.value as! [String:Any]
                let nome = value["nome"] as! String
                let descricao = value["descricao"] as! String
                let dtInicio = Date.toDate(date: value["dtInicio"] as! String)
                let hrInicio = Date.toDate(date: value["hrInicio"] as! String)
                let relevancia = value["relevancia"] as! Int
                let status = value["status"] as! Bool
                let email = value["email"] as! String
                let item = ToDoItem(nome: nome, descricao: descricao,dtInicio: dtInicio,hrInicio:hrInicio,
                                    relevancia:relevancia,status:status,email:email, key: child.key, ref: child.ref)
                self.items.append(item)
            }
            self.tableView.reloadData()
            
        }){
            (error) in
            print("\(error.localizedDescription)")
        }
        
        self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).child("items").observe(.childAdded, with:{ (snapshot) in
            let child = snapshot
            let value = child.value as! [String:Any]
            let nome = value["nome"] as! String
            let descricao = value["descricao"] as! String
            let dtInicio = Date.toDate(date: value["dtInicio"] as! String)
            let hrInicio = Date.toDate(date: value["hrInicio"] as! String)
            let relevancia = value["relevancia"] as! Int
            let status = value["status"] as! Bool
            let email = value["email"] as! String
            let item = ToDoItem(nome: nome, descricao: descricao,dtInicio: dtInicio,hrInicio:hrInicio,
                                relevancia:relevancia,status:status,email:email, key: child.key, ref: child.ref)
            self.items.append(item)
            let indexPath = IndexPath(row: self.items.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            
        })
        
        self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).child("items").observe(.childRemoved, with:{ (snapshot) in
            
            for(index, item) in self.items.enumerated(){
                if item.ref!.key == snapshot.key{
                    self.items.remove(at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                    break;
                }
            }
        })
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
        
        cell.textLabel?.text = item.nome
        cell.detailTextLabel?.text = item.dtInicio.toString(format: "dd/MM/yyyy") + " " + item.hrInicio.toString(format: "HH:mm")
        
        return cell
    }

 
    
    @IBAction func unwindToMealList(segue:UIStoryboardSegue){
        if(segue.identifier == "add"){
            if let svc = segue.source as? ToDoItemViewController{
                if let indexPath = self.tableView.indexPathForSelectedRow{
                    self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).child("items").child(svc.item!.key!).updateChildValues(svc.item!.toDictionary())
                    self.items[indexPath.row] = svc.item!
                }else{
                    self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).child("items").childByAutoId().setValue((svc.item!.toDictionary()))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToRemove = self.items[indexPath.row]
            itemToRemove.ref!.removeValue()
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
