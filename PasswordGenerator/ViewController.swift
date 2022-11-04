//
//  ViewController.swift
//  PasswordGenerator
//
//  Created by Miraç Doğan on 4.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func Create(_ sender: Any) {
        textView.textAlignment = .center
        textView.text = generateRandomPassword(of: 20)
        UIPasteboard.general.string = textView.text
    }

}

