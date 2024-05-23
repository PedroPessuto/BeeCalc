//
//  CalculatorView.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 17/05/24.
//

import UIKit

    class CalculatorView: UIViewController {
        
        // ========== ATTRIBUTES ==========
        
        let formula: Formula
        let generalController: GeneralController = GeneralController.shared
        let update: @MainActor () async -> ()
        let header: UIView = UIView()
        let backButton: Button = Button(systemName: "house.fill")
        let input: UITextField = UITextField()
        let screen: UIView = UIView()
        let displayView: UIView = UIView()
        let expressionView: UIScrollView = UIScrollView()
        let messageContainer: UIView = UIView()
        let buttonContainer: UIView = UIView()
        
        
        // ========== METHODS ==========
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
            setupView()
        }
        
        private func setupView() {
            view.backgroundColor = UIColor(named: "CinzaClaro")
            setElements()
        }
        
        private func setElements() {
            setToolbar()
            setDisplay()
            setMessage()
            setButtons()
        }
        
        @objc private func backButtonAction() {
            Task {
                formula.name = input.text ?? ""
                await update()
                navigationController?.popViewController(animated: true)
            }
            
        }
        
        let buttons: [[Button]] = [
            [Button(buttonText: "7"), Button(buttonText: "8"), Button(buttonText: "9"), Button(variant: .pink, systemName: "delete.left.fill")],
            [Button(buttonText: "4"), Button(buttonText: "5"), Button(buttonText: "6"), Button(buttonText: "N", variant: .yellow)],
            [Button(buttonText: "1"), Button(buttonText: "2"), Button(buttonText: "3"), Button(buttonText: "NP", variant: .yellow)],
            [Button(buttonText: "0"), Button(buttonText: ".", variant: .yellow)]
        ]
        
        // ========== METHODS ==========
        
        
        private func setToolbar() {
            self.view.addSubview(header)
            header.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                header.heightAnchor.constraint(equalToConstant: 65)
            ])
            
            // Back Button
            header.addSubview(backButton)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            
            let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(backButtonAction))
            backButton.addGestureRecognizer(backButtonTap)
            
            NSLayoutConstraint.activate([
                backButton.widthAnchor.constraint(equalToConstant: 65),
                backButton.heightAnchor.constraint(equalToConstant: 65),
                backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor)
            ])
            
            // TextField
            header.addSubview(input)
            input.translatesAutoresizingMaskIntoConstraints = false
            input.text = formula.name
            input.backgroundColor = UIColor(named: "Cinza")
            input.font = .systemFont(ofSize: 24, weight: .bold)
            input.textColor = UIColor(named: "Roxo")
            input.layer.cornerRadius = 10
            input.textAlignment = .center
            
            NSLayoutConstraint.activate([
                input.heightAnchor.constraint(equalToConstant: 65),
                input.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
                input.trailingAnchor.constraint(equalTo: header.trailingAnchor)
            ])
            
        }
        
        private func setDisplay() {
            view.addSubview(displayView)
            displayView.translatesAutoresizingMaskIntoConstraints = false
            displayView.backgroundColor = UIColor(named: "Roxo")
            displayView.layer.cornerRadius = 10
            
            
            NSLayoutConstraint.activate([
                displayView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 30),
                displayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                displayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                displayView.heightAnchor.constraint(equalToConstant: 250),
            ])
            
            
    //        if (!formula.fraction.isEmpty) {
            if (true) {
                view.addSubview(expressionView)
                expressionView.translatesAutoresizingMaskIntoConstraints = false
                expressionView.showsVerticalScrollIndicator = false
                expressionView.backgroundColor = .green
                
                NSLayoutConstraint.activate([
                    expressionView.centerYAnchor.constraint(equalTo: displayView.centerYAnchor),
                    expressionView.topAnchor.constraint(equalTo: displayView.topAnchor, constant: 20),
                    expressionView.bottomAnchor.constraint(equalTo: displayView.bottomAnchor, constant: -20),
                    expressionView.leadingAnchor.constraint(equalTo: displayView.leadingAnchor, constant: 20),
                    expressionView.trailingAnchor.constraint(equalTo: displayView.trailingAnchor, constant: -20),
                ])
                
                
                let fractionView = UIView()
                
                expressionView.addSubview(fractionView)
                fractionView.translatesAutoresizingMaskIntoConstraints = false
                fractionView.backgroundColor = .blue
                
                NSLayoutConstraint.activate([
                    fractionView.centerYAnchor.constraint(equalTo: expressionView.centerYAnchor),
                    fractionView.topAnchor.constraint(equalTo: expressionView.topAnchor),
                    fractionView.bottomAnchor.constraint(equalTo: expressionView.bottomAnchor),
                    fractionView.leadingAnchor.constraint(equalTo: expressionView.leadingAnchor),
//                                        fractionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
//                    fractionView.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
                ])
                
                // Linha de cima
                let stack: UIStackView = UIStackView()
                fractionView.addSubview(stack)
                stack.axis = .horizontal
                stack.spacing = 101
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.backgroundColor = .orange
                
                NSLayoutConstraint.activate([
                    stack.centerYAnchor.constraint(equalTo: fractionView.centerYAnchor),
                    stack.leadingAnchor.constraint(equalTo: fractionView.leadingAnchor),
    //                stack.heightAnchor.constraint(equalTo: fractionView.heightAnchor),
    //                stack.widthAnchor.constraint(equalTo: fractionView.widthAnchor)
                    stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
                    stack.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
                ])
                
                for i in formula.fraction.indices {
//                for i in 0..<5 {
                    
                    if i % 2 == 0 {
                        continue
                    }
                    
                    let container = UIView()
                    let number = NumberCard(text: formula.fraction[i-1], variant: .number)
//                    let number = NumberCard(text: "n1", variant: .number)
                    let operation = NumberCard(text: "x", variant: .operation)
//                    let weight = NumberCard(text: "p1", variant: .number)
                                    let weight = NumberCard(text: formula.fraction[i], variant: .number)

                
                    container.addSubview(number)
                    NSLayoutConstraint.activate([
                        number.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    ])
                    
                    container.addSubview(operation)
                    NSLayoutConstraint.activate([
                        operation.leadingAnchor.constraint(equalTo: number.trailingAnchor, constant: 5),
                    ])
                    
                    container.addSubview(weight)
                    NSLayoutConstraint.activate([
                        weight.leadingAnchor.constraint(equalTo: operation.trailingAnchor, constant: 5),
                    ])
                    
                    stack.addArrangedSubview(container)
                }
                
                expressionView.addSubview(stack)
                
            }
            
        }
        
        private func setMessage() {
            view.addSubview(messageContainer)
            messageContainer.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                messageContainer.heightAnchor.constraint(equalToConstant: 50),
                messageContainer.topAnchor.constraint(equalTo: displayView.bottomAnchor, constant: 30),
                messageContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                messageContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ])
            
            let colorContainer = UIView()
            colorContainer.translatesAutoresizingMaskIntoConstraints = false
            colorContainer.backgroundColor = UIColor(named: "Rosa")
            colorContainer.layer.cornerRadius = 10
            colorContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            
            messageContainer.addSubview(colorContainer)
            NSLayoutConstraint.activate([
                colorContainer.heightAnchor.constraint(equalToConstant: 50),
                colorContainer.widthAnchor.constraint(equalToConstant: 10),
                colorContainer.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor),
            ])
            
            let textContainer = UIView()
            textContainer.translatesAutoresizingMaskIntoConstraints = false
            textContainer.backgroundColor = UIColor(named: "Cinza")
            textContainer.layer.cornerRadius = 10
            textContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            messageContainer.addSubview(textContainer)
            
            NSLayoutConstraint.activate([
                textContainer.heightAnchor.constraint(equalToConstant: 50),
                textContainer.leadingAnchor.constraint(equalTo: colorContainer.trailingAnchor),
                textContainer.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor)
            ])
            
            let text: UILabel = P(text: nil)
            textContainer.addSubview(text)
            text.translatesAutoresizingMaskIntoConstraints = false
            text.text = generalController.resultText
            
            NSLayoutConstraint.activate([
                text.leadingAnchor.constraint(equalTo: messageContainer.leadingAnchor, constant: 20),
                text.trailingAnchor.constraint(equalTo: messageContainer.trailingAnchor, constant: -20),
                text.heightAnchor.constraint(equalToConstant: 50)
            ])
            
        }
        
        private func setButtons() {
            view.addSubview(buttonContainer)
            buttonContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let buttonContainer = UIStackView()
            buttonContainer.axis = .vertical
            buttonContainer.spacing = 25
            buttonContainer.translatesAutoresizingMaskIntoConstraints = false
            
            for row in buttons {
                let buttonRow = UIStackView()
                buttonRow.axis = .horizontal
                buttonRow.spacing = 20
                buttonRow.distribution = .fillEqually
                
                for button in row {
                    buttonRow.addArrangedSubview(button)
                }
                buttonContainer.addArrangedSubview(buttonRow)
            }
            
            view.addSubview(buttonContainer)
            
            NSLayoutConstraint.activate([
                buttonContainer.topAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: 30),
                buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
        }
        
        // ========== CONSTRUCTORS ==========
        init(formula: Formula, update: @escaping @MainActor () async -> ()) {
            self.formula = formula
            self.update = update
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            return nil
        }
        
    }



//        NSLayoutConstraint.activate([
//            buttonContainer.topAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: 20),
//            buttonContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            buttonContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            buttonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//
//        let row1: UIView = UIView()
//        buttonContainer.addSubview(row1)
//        row1.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            row1.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
//            row1.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
//            row1.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor),
//        ])
//
//        let button7: Button = Button(buttonText: "7", variant: .purple)
//        button7.translatesAutoresizingMaskIntoConstraints = false
//        row1.addSubview(button7)
//
//        NSLayoutConstraint.activate([
//            button7.topAnchor.constraint(equalTo: row1.topAnchor),
//            button7.leadingAnchor.constraint(equalTo: row1.leadingAnchor),
//            button7.widthAnchor.constraint(equalToConstant: 65),
//            button7.heightAnchor.constraint(equalToConstant: 65)
//        ])
//
//        let button8: Button = Button(buttonText: "8", variant: .purple)
//        button8.translatesAutoresizingMaskIntoConstraints = false
//        row1.addSubview(button8)
//
//        NSLayoutConstraint.activate([
//            button8.topAnchor.constraint(equalTo: row1.topAnchor),
//            button8.leadingAnchor.constraint(equalTo: button7.trailingAnchor),
//            button8.widthAnchor.constraint(equalToConstant: 65),
//            button8.heightAnchor.constraint(equalToConstant: 65)
//        ])




//            let numbersWithWeights = UIView()
//            fractionView.addSubview(numbersWithWeights)
//            numbersWithWeights.translatesAutoresizingMaskIntoConstraints = false
//
////            for i in formula.fraction.indices {
//            for i in 0..<10 {
//
//                let view = UIView()
//                view.translatesAutoresizingMaskIntoConstraints = false
//
//                if i % 2 == 0 {
//                    view.backgroundColor = UIColor(named: "CinzaClaro")
//                    let card = NumberCard(text: "n\(i + 1)", variant: .number)
//                    view.addSubview(card)
//
//                    NSLayoutConstraint.activate([
//                        card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                        card.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                        card.topAnchor.constraint(equalTo: view.topAnchor),
//                        card.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//                    ])
//                }
//
//            }
//
//
//
//            let divisionBar = UIView()
//            divisionBar.translatesAutoresizingMaskIntoConstraints = false
//            divisionBar.backgroundColor = UIColor(named: "Cinza")
//
//            let onlyWeights = UIView()
//            onlyWeights.translatesAutoresizingMaskIntoConstraints = false
//
//
//
