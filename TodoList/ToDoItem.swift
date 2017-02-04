
import Foundation
import UIKit

class ToDoItem: NSObject {
    
    var nome:String?
    var descricao:String?
    var dtInicio: Date?
    var hrInicio: Date?
    var relevancia: Int?
    var status: Bool?
    
    init(nome:String, descricao:String, dtInicio:Date, hrInicio: Date, relevancia:Int, status:Bool) {
        self.nome = nome
        self.descricao = descricao
        self.dtInicio = dtInicio
        self.hrInicio = hrInicio
        self.relevancia = relevancia
        self.status = status
    }
}
