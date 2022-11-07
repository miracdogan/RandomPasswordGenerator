//
//  ViewController.swift
//  PasswordGenerator
//
//  Created by Miraç Doğan on 4.11.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textView: UITextField!
    @IBOutlet var CopyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isUserInteractionEnabled = false
        self.view.backgroundColor = UIColor.white
    }

    func generateRandomPassword(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var password = ""
        
        for _ in 0 ..< length {
            password.append(letters.randomElement()!)
        }
        
        return password
    }
    
    
    @IBAction func NextPageAction(_ sender: Any) {
        let nameStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = nameStoryBoard.instantiateViewController(withIdentifier: "PasswordViewController")
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func Create(_ sender: Any) {
        textView.textAlignment = .center
        textView.text = generateRandomPassword(of: 17)
        UIPasteboard.general.string = textView.text
    }

    @IBAction func CopyPassword(_ sender: Any) {
        UIPasteboard.general.string = textView.text
        
        let ac = UIAlertController(title: title, message: "Copied Successfully!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
}

