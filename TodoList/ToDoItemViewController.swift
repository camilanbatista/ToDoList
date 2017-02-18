import UIKit
import FirebaseDatabase
import Firebase

class ToDoItemViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var item:ToDoItem?

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var dtInicio: UIDatePicker!
    @IBOutlet weak var hrInicio: UIDatePicker!
    @IBOutlet weak var relevancia: UISegmentedControl!
    @IBOutlet weak var status: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = self.item{
            self.nome.text = item.nome
            self.descricao.text = item.descricao
            self.dtInicio.date = item.dtInicio
            self.hrInicio.date = item.hrInicio
            self.relevancia.selectedSegmentIndex = item.relevancia
            self.status.isOn = item.status
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "add"){
            let newItem = ToDoItem(nome: self.nome.text!, descricao: self.descricao.text! ,
                                   dtInicio: self.dtInicio.date,hrInicio: self.hrInicio.date, relevancia: self.relevancia.selectedSegmentIndex, status : self.status.isOn, email:FIRAuth.auth()!.currentUser!.email!,key: item?.key!, ref: item?.ref!)
            self.item = newItem
            
        }
    }
    
}






