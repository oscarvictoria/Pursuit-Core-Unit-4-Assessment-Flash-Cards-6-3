//
//  CreateCardViewController.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardViewController: UIViewController {
    
    public var dataPersistance: DataPersistence<FlashCards>!
    
    var cardObject = [FlashCards]()
    
    var createView = CreateView()
    
    override func loadView() {
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureNavBar()
        configureTextFields()
    }
    
    func configureTextFields() {
        createView.textField.delegate = self
        createView.textField.placeholder = "Title goes here"
        createView.textField.textColor = UIColor.lightGray
        
        createView.textViewOne.delegate = self
        createView.textViewOne.textColor = UIColor.lightGray
        
        createView.textViewTwo.delegate = self
        createView.textViewTwo.textColor = UIColor.lightGray
    }
    
    func configureNavBar() {
        navigationItem.title = "Create Card"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(create))
    }
    
   
    
    @objc private func create() {
        do {
        guard let title = createView.textField.text, !title.isEmpty,
            let fact = createView.textViewOne.text,!fact.isEmpty,
            let factTwo = createView.textViewTwo.text, !factTwo.isEmpty else {
                let alert = UIAlertController(title: "Sorry, could not create flash card", message: "Fill out all fields to create flashcard", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            return
        }
        let cardObject = FlashCards(id: "0", quizTitle: title, facts: [fact, factTwo])
        try dataPersistance.createItem(cardObject)
        let alert = UIAlertController(title: "Flash Card succesfully created", message: "check your cards to see", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
            
        } catch {
            print("could not get card")
        }
    }
    
    @objc private func cancel() {
        clearText()
    }
    
    func clearText() {
        createView.textField.text = ""
        createView.textViewOne.text = ""
        createView.textViewTwo.text = ""
    }
    
}

extension CreateCardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = ""
            textField.textColor = UIColor.black
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension CreateCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
  
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
     }
    
    

}
