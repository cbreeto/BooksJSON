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
        
        getInfoJSON(isbnField.text!)
        
        
        return true
        
    }
    
    func getInfoJSON(id : String) -> Void {
        
        let isbn = self.isbnTextField.text
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn!
        let id = "ISBN" + isbn!
        
        
        let url = NSURL(string: urls)
        
        let datos = NSData(contentsOfURL: url!)
        

        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
        
            let dict1 = json as! NSDictionary
            let dict2 = dict1[id] as! NSDictionary
            
            tituloLbl.text = dict2["title"] as! NSString as String
            let cadena : String = dict2["by_statement"] as! NSString as String
            let until : Character = ";"
            
            let author : String = (cadena.substringToIndex(cadena.characters.indexOf(
                until)!))
            
            autor1Lbl.text = author
            pagesLbl.text = dict2["notes"] as! NSString as String
            
            
            //  autor1Lbl.text = dict3[1] as!
            //     NSString as String  No se puede convertir un NSDictionary a un NSString. Busque en muchos lados pero no me salió
            
        }catch _ {
            
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

