//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Oscar Victoria Gonzalez  on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var textViewTwo: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        return textView
    }()
    
    public lazy var textViewOne: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        return textView
    }()
    
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.placeholder = "Title"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureTextField()
        configureTextViewOne()
        configureTextViewTwo()
    }
    
    private func configureTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureTextViewOne() {
        addSubview(textViewOne)
        textViewOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textViewOne.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            textViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textViewOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textViewOne.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func configureTextViewTwo() {
        addSubview(textViewTwo)
        textViewTwo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textViewTwo.topAnchor.constraint(equalTo: textViewOne.bottomAnchor, constant: 20),
            textViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textViewTwo.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}

