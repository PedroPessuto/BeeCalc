//
//  HomeViewController.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 14/05/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // ========== ATTRIBUTES ==========
    let generalController: GeneralController = GeneralController.shared
    let header: UIView = UIView()
    let addButton: Button = Button(systemName: "plus")
    let importButton: Button = Button(systemName: "square.and.arrow.down.fill")
    let text: BigTitle = BigTitle(text: "Fórmulas")
    let list: UIScrollView = UIScrollView()
    let stackView: UIStackView = UIStackView()
    
    // ========== METHODS ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    
    private func setElements() {
        setBackground()
        setToolbar()
        setTitle()
        setList()
        setCards()
    }
    
    private func setBackground() {
        self.view.backgroundColor = UIColor(named: "CinzaClaro")
    }
    
    private func setToolbar() {
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            header.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        // Add Button
        header.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 65),
            addButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 65),
            addButton.trailingAnchor.constraint(equalTo: header.trailingAnchor),
        ])
        
        // Import Button
        header.addSubview(importButton)
        importButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            importButton.widthAnchor.constraint(equalToConstant: 65),
            importButton.heightAnchor.constraint(equalToConstant: 65),
            importButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            importButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor)
        ])
    }
    
    private func setTitle() {
        view.addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: header.bottomAnchor),
            text.leadingAnchor.constraint(equalTo: header.leadingAnchor)
        ])
    }
    
    private func setList() {
        view.addSubview(list)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            list.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            list.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            list.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            list.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
                
        list.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: list.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: list.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: list.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: list.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: list.widthAnchor)
        ])
    }
    
    private func setCards() {
        for i in 1...10 {
            let card = Card(formula: Formula(name: "Teste \(i)"))
            stackView.addArrangedSubview(card)
        }
    }
}


#Preview {
    HomeViewController()
}

