//
//  ViewController.swift
//  week1-Palindrome
//
//  Created by Domagoj Bunoza on 02.08.2021..
//

import UIKit

class ViewController: UIViewController {
    
    var inputText: UITextField!
    var checkButton: UIButton!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        inputText = UITextField()
        inputText.translatesAutoresizingMaskIntoConstraints = false
        inputText.textAlignment = .left
        inputText.placeholder = "Insert palindrome"
        
        view.addSubview(inputText)
                
        NSLayoutConstraint.activate([
            inputText.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            inputText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputText.widthAnchor.constraint(equalToConstant: 300),
        ]
        )
        
        checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.backgroundColor = UIColor.systemBlue
        checkButton.setTitle("Check", for: .normal)
        checkButton.titleLabel?.font = UIFont(name: "Arial Unicode MS", size: 20)
        view.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 50),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 150)
        ]
        )
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Palindrome";
        
        checkButton.addTarget(self, action: #selector(click(_sender:)), for: .touchUpInside)

    }
    
    @objc func click(_sender: UIButton!){
        
        let boldAtributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Avenir Next Condensed Bold", size: 18.0)!]
        let greenAtributes = [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.font: UIFont(name: "Avenir Next Condensed", size: 18.0)!]
        let redAtributes = [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont(name: "Avenir Next Condensed", size: 18.0)!]
        let defaultAtributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Avenir Next Condensed", size: 18.0)!]

        let partOneCorrect = NSMutableAttributedString(string: "The entered word is a palindrome!\n", attributes: defaultAtributes)
        let partOneIncorrect = NSMutableAttributedString(string: "The entered word is not a palindrome!\n", attributes: defaultAtributes)
        let partOneInvalid = NSMutableAttributedString(string: "Entry was not a valid word. Try to add\n", attributes: defaultAtributes)
        
        let greenPart = NSMutableAttributedString(string: "Do you know some other palindrome?", attributes: greenAtributes)
        let redPart = NSMutableAttributedString(string: "Try a different word.", attributes: redAtributes)
        let boldPart = NSMutableAttributedString(string: "a word which is a palindrome.", attributes: boldAtributes)

        let combination = NSMutableAttributedString()
        let title: String
        let key: String
        
        switch checkForPalindrome() {
        case Cases.Empty:
            title = "Incorrect"
            combination.append(partOneInvalid)
            combination.append(boldPart)
            key = "Try again"
        case Cases.Palindrome:
            title = "Correct"
            combination.append(partOneCorrect)
            combination.append(greenPart)
            key = "Enter new palindrome"
        default:
            title = "Incorrect"
            combination.append(partOneIncorrect)
            combination.append(redPart)
            key = "Try again"
        }
        let currentTitle = NSMutableAttributedString(string: title, attributes: boldAtributes)
        
        
        let alert = UIAlertController(title: title, message: combination.string, preferredStyle: .alert)
        alert.setValue(currentTitle, forKey: "attributedTitle")
        alert.setValue(combination, forKey: "attributedMessage")
        let alertAction = UIAlertAction(title: key, style: .default, handler: nil)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }


    func checkForPalindrome()->Cases{
        if inputText.hasText {
            if inputText.text?.lowercased() == String(inputText.text!.lowercased().reversed()) {
                return Cases.Palindrome
            } else {
                return Cases.NotPalindrome
            }
        } else {
            return Cases.Empty
        }
    }
}

