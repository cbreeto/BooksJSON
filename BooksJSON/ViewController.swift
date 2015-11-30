//
//  ViewController.swift
//  BooksJSON
//
//  Created by Carlos Brito on 26/11/15.
//  Copyright © 2015 Carlos Brito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var autor1Lbl: UILabel!
    @IBOutlet weak var autor2Lbl: UILabel!
    @IBOutlet weak var autor3Lbl: UILabel!
    @IBOutlet weak var portadaLbl: UILabel!
    
    @IBOutlet weak var pagesLbl: UILabel!
    
    @IBOutlet weak var anioLbl: UILabel!
    
    func textFieldShouldReturn(isbnField: UITextField) -> Bool {
        isbnTextField.resignFirstResponder()
        if isbnTextField.text != "" {
            getInfoJSON(isbnField.text!)
        }
        else {
            emptyField()
        }
        return true
    }
    
    func emptyField() -> Void {
        let alerta = UIAlertController(title: "Incompleto", message: "Falta introducir ISBN a buscar", preferredStyle: .Alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    func getInfoJSON(id : String) -> Void {
        
        let isbn = self.isbnTextField.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn!
        let id = "ISBN:" + isbn!
        
        
        let url = NSURL(string: urls)
        
        let datos: NSData? = NSData(contentsOfURL: url!)
        

        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            print(id)
            let dict1 = json as! NSDictionary
            let dict2 = dict1[id] as! NSDictionary
            tituloLbl.text = dict2["title"] as! NSString as String
            
            //Otra forma de obtener autor
            //let cadena : String = dict2["by_statement"] as! NSString as String
            //let until : Character = ";"
            
            //let author : String = (cadena.substringToIndex(cadena.characters.indexOf(
            //    until)!))
            
            let dict3 = dict2["authors"] as! NSArray
            dict3.enumerateObjectsUsingBlock({ objeto, index, stop in
                let dict4 = objeto["name"] as! String
                self.autor1Lbl.text = dict4
            })
            
            let dict5 = dict2["cover"] as? NSDictionary
            if dict5 == nil {
                let alerta = UIAlertController(title: "Alerta", message: "No hay imagen de cover", preferredStyle: .Alert)
                alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alerta, animated: true, completion: nil)
            } else {
                pagesLbl.text = "El libro si cuenta con cover"
            }
            pagesLbl.text = dict2["notes"] as! NSString as String
            
        }catch _ {
            print("Error en JSONSerializacion")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbnTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

