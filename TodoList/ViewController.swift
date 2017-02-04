//
//  ViewController.swift
//  TodoList
//
//  Created by ios on 04/02/17.
//  Copyright © 2017 com.fa7. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var senha: UITextField!
    
    @IBAction func btnEntrar(_ sender: UIButton) {
    
        FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.senha.text!){
            (user, error) in
            if let errorResult = error{
                
                let alert = UIAlertController(title: "Alerta", message: "Usuário ou senha incorretos.", preferredStyle: .alert);
                let closeAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil);
                alert.addAction(closeAction);
                self.present(alert, animated: true, completion: nil);
                print("\(errorResult.localizedDescription)")
            }else{
                print("Login executado com sucesso com uid: \(user?.uid)")
            }
        }
    }
    
    @IBAction func criarUsuario(_ sender: UIButton) {
        FIRAuth.auth()?.createUser(withEmail: self.email.text!, password: self.senha.text!){ (user, error) in
            if let errorResult = error {
                let alert = UIAlertController(title: "Alerta", message: "Erro ao criar usuário.", preferredStyle: .alert);
                let closeAction = UIAlertAction(title: "Fechar", style: .cancel, handler: nil);
                alert.addAction(closeAction);
                self.present(alert, animated: true, completion: nil);
                print("\(errorResult.localizedDescription)")
            } else{
                print("Sucesso! Conta criada com  uid: \(user!.uid)")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addStateDidChangeListener(){ (auth, user) in
            if let _ = user {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

