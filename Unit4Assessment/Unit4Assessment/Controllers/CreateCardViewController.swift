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
    
    //    detailView.textView.text = "Caption Goes Here"
    //          detailView.textView.textColor = UIColor.lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        configureNavBar()
        configureTextFields()
    }
    
    func configureTextFields() {
        createView.textField.delegate = self
        createView.textField.text = "Title goes here"
        createView.textField.textColor = UIColor.lightGray
        
        createView.textViewOne.delegate = self
        createView.textViewOne.text = "Write Something"
        createView.textViewOne.textColor = UIColor.lightGray
        
        createView.textViewTwo.delegate = self
        createView.textViewTwo.text = "Write Something"
        createView.textViewTwo.textColor = UIColor.lightGray
    }
    
    func configureNavBar() {
        navigationItem.title = "Create Card"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(create))
    }
    
    @objc private func create() {
        let cardObject = FlashCards(id: "0", quizTitle: createView.textField.text ?? "", facts: [createView.textViewOne.text, createView.textViewTwo.text])
        do {
            try dataPersistance.createItem(cardObject)
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
    
}

extension CreateCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
