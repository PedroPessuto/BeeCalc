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
    
    @objc private func addFormula() {
        Task {
            let response = await self.generalController.addFormula()
            if case .success(let formula) = response {
                self.navigationController?.pushViewController(NumberView(formula: formula, update: updateStack), animated: true)
            }
            
        }
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
        
//        header.addSubview(importButton)
//        importButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            importButton.widthAnchor.constraint(equalToConstant: 65),
//            importButton.heightAnchor.constraint(equalToConstant: 65),
//            importButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
//            importButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor)
//        ])
        
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
    
    func updateStack() async {
        for viewInStack in stackView.subviews {
            stackView.removeArrangedSubview(viewInStack)
            viewInStack.removeFromSuperview()
        }
        
        let _ = await generalController.getFormulas()
        for i in 0..<generalController.formulas.count {
            let card = Card(formula: generalController.formulas[i])
            card.deleteAction = { [weak self] in
                await self?.updateStack()
            }
            card.editAction = { [weak self] in
                guard let self = self else { return }
                self.navigationController?.pushViewController(NumberView(formula: self.generalController.formulas[i], update: updateStack), animated: true)
            }
            stackView.addArrangedSubview(card)
        }
    }
    
    
    
    private func setCards() {
        Task {
            await updateStack()
        }
    }
}


#Preview {
    UINavigationController(rootViewController: HomeView())
}

