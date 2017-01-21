
import UIKit

//MARK: Estrutura Sandbox
let caminhoSandbox = NSHomeDirectory()
let caminhoDocuments = (caminhoSandbox as NSString).appendingPathComponent("Documents")
let caminhoArquivo = (caminhoDocuments as NSString).appendingPathComponent("lembretes.plist")

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Outlets
    @IBOutlet weak var entradaTexto: UITextField!
    @IBOutlet weak var resgateTexto: UITextView!
    
    //MARK: Propriedades
    var arrayLembretes : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Gerenciador de arquivos
        
        self.entradaTexto.delegate = self
        
        let gerenciadorArquivos = FileManager.default
        
        if gerenciadorArquivos.fileExists(atPath: caminhoArquivo){
            let arrayResgatado = NSArray(contentsOfFile: caminhoArquivo)
            arrayLembretes = arrayResgatado as! Array
            resgateTexto.text = formataString(arrayLembretes)
            
        } else {
            resgateTexto.text = "Não há lembretes para serem exibidos"
        }
        

    }

    //MARK: Actions
    @IBAction func apagarLembretes(_ sender: UIButton) {
        if FileManager.default.fileExists(atPath: caminhoArquivo){
            do {
                try FileManager.default.removeItem(atPath: caminhoArquivo)
            } catch{}
            
            arrayLembretes = []
            resgateTexto.text = ""
        }
        
        resgateTexto.text = "Não há lembretes para serem exibidos"
    }
    
    //MARK: Métodos de TextFieldDeledate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if !(entradaTexto.text!.isEmpty){
            let lembrete = entradaTexto.text!
            arrayLembretes += [lembrete]
            let arrayConvertido = arrayLembretes as NSArray
            arrayConvertido.write(toFile: caminhoArquivo, atomically: true)
            resgateTexto.text = formataString(arrayLembretes)
            entradaTexto.text = ""
            entradaTexto.resignFirstResponder()
        }
        
        return true
    }
    
    
    //MARK: Metodos de UIResponder
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    //MARK: Métodos personalizados
    func formataString(_ meuArray : Array<String>) -> String{
        var stringFormatada = ""
        for e in meuArray{
            stringFormatada += "Lembrete: \(e)\n"
        }
        return stringFormatada
    }



}

