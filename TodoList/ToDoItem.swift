
import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ToDoItem: NSObject {
    
    var nome:String
    var descricao:String
    var dtInicio: Date
    var hrInicio: Date
    var relevancia: Int
    var status: Bool
    var email:String
    var key:String?
    var ref:FIRDatabaseReference?
    
    init(nome:String, descricao:String, dtInicio:Date, hrInicio: Date, relevancia:Int, status:Bool,email:String,key:String?,ref:FIRDatabaseReference?) {
        self.nome = nome
        self.descricao = descricao
        self.dtInicio = dtInicio
        self.hrInicio = hrInicio
        self.relevancia = relevancia
        self.status = status
        self.email = email
        self.key = key
        self.ref = ref
    }
    
       
    func toDictionary() -> [String:Any]{        
        
        return ["nome":nome, "descricao":descricao,"dtInicio": Date().toString(),"hrInicio":Date().toString(),"relevancia":relevancia, "status":status, "email":email]
    }

}
