//
//  CalculatorView.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 17/05/24.
//

import UIKit

class CalculatorView: UIViewController {
    
    // ========== ATTRIBUTES ==========
    let formula: Formula?
    let header: UIView = UIView()
    let backButton: Button = Button(systemName: "house.fill")
    
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
    }
    
    @objc private func backButtonAction() {
//        navigationController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
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
        backButton.addGestureRecognizer(addButtonTap)

        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 65),
            backButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 65),
            backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor),
        ])
    }
    
    // ========== CONSTRUCTORS ==========
    init(formula: Formula? = nil) {
        self.formula = formula
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
