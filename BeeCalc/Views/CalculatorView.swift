//
//  CalculatorView.swift
//  BeeCalc
//
//  Created by Sofia Lee on 17/05/24.
//

import UIKit

class CalculatorView: UIViewController {
    
    // ========== ATTRIBUTES ==========
    let header: UIView = UIView()
    let backButton: Button = Button(systemName: "house.fill")
    
    // ========== METHODS ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "CinzaClaro")
        setElements()
    }
    
    private func setElements() {
        setToolbar()
    }
    
    @objc private func backButtonAction() {
        self.presentedViewController?.dismiss(animated: false, completion: nil)
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
        header.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        let addButtonTap = UITapGestureRecognizer(target: self, action: #selector(backButtonAction))
        backButton.gestureRecognizers?.append(addButtonTap)

        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 65),
            backButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 65),
            backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor),
        ])

//        // Import Button
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
    // ========== CONSTUCTORS ==========
    
    
}


