//
//  HomeViewController.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 14/05/24.
//

import UIKit

class HomeView: UIViewController {
    
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
    
    private func dismissCalcView() {
        dismiss(animated: true)
    }
    
    @objc private func addFormula() {
        self.navigationController?.pushViewController(CalculatorView(), animated: true)
        print("Foi")
        Task {
            await self.generalController.addFormula()
        }
        setCards()

        
        
//        let calculatorView = CalculatorView()
//        calculatorView.modalPresentationStyle = .fullScreen
//        present(calculatorView, animated: true, completion: nil)
        
        
//        let response = await generalController.addFormula()
//        if case .success(let formula) = response {
//            navigationController?.pushViewController(CalculatorView(formula: formula), animated: true)
//        }
    }
    
    private func setToolbar() {
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            header.heightAnchor.constraint(equalToConstant: 65)
        ])
        
        // Add Button
        header.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let addButtonTap = UITapGestureRecognizer(target: self, action: #selector(addFormula))
        addButton.gestureRecognizers?.append(addButtonTap)
        
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
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: list.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: list.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: list.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: list.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: list.widthAnchor)
        ])
    }
    
    func teste() {
        print("Edit action triggered")
    }
    
    
    private func setCards() {
        //        for i in 0..<10 {
        //            let card = Card(formula: Formula(name: "Teste \(i + 1)"))
        //            card.editAction = teste
        //            card.deleteAction = teste
        //            stackView.addArrangedSubview(card)
        //        }
        for viewInStack in stackView.subviews {
            stackView.removeArrangedSubview(viewInStack)
        }
            
            
        for i in 0..<generalController.formulas.count {
            let card = Card(formula: generalController.formulas[i])

//        card.deleteAction = generalController.deleteFormula(generalController.formulas[i])
            stackView.addArrangedSubview(card)
        }
    }
}


#Preview {
    UINavigationController(rootViewController: HomeView())
}

