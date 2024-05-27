//
//  FormulaView.swift
//  BeeCalc
//
//  Created by Sofia Lee on 27/05/24.
//

import UIKit


class FormulaView: UIViewController, UITextFieldDelegate {
    
    // ========== ATTRIBUTES ==========
    
    let formula: Formula
    let generalController: GeneralController = GeneralController.shared
    let update: @MainActor () async -> ()
    let header: UIView = UIView()
    let backButton: Button = Button(systemName: "house.fill")
    let input: UITextField = UITextField()
    let text = MiniTitle(text: "Escreva a fórmula da sua prova")
    let formulaInput = UITextField()
    let text2 = MiniTitle(text: "Importância da Prova")
    
    var rating: Int = 0
    var starButtons: [UIButton] = []
    
    var result: String = ""
    
    // ========== METHODS ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        formulaInput.text = formula.formula
        rating = formula.rating
        setupView()
        updateStarButtons() // Adicionar esta linha para refletir o rating inicial
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "CinzaClaro")
        setElements()
    }
    
    private func setElements() {
        setToolbar()
        setText()
        setInput()
        setText2()
        setRating()
    }
    
    @objc private func backButtonAction() {
        Task {
            formula.name = input.text ?? ""
            formula.formula = formulaInput.text ?? ""
            formula.rating = rating
            await update()
            navigationController?.popViewController(animated: true)
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
    
    private func setText() {
        text.textColor = UIColor(named: "Roxo")
        self.view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            text.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func setInput() {
        self.view.addSubview(formulaInput)
        formulaInput.translatesAutoresizingMaskIntoConstraints = false
        formulaInput.text = formula.formula
        formulaInput.backgroundColor = UIColor(named: "Cinza")
        formulaInput.font = .systemFont(ofSize: 24, weight: .bold)
        formulaInput.textColor = UIColor(named: "Roxo")
        formulaInput.layer.cornerRadius = 10
        formulaInput.textAlignment = .center
        
        NSLayoutConstraint.activate([
            formulaInput.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            formulaInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            formulaInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            formulaInput.heightAnchor.constraint(equalToConstant: 65),
        ])
    }
    
    private func setText2() {
        text2.textColor = UIColor(named: "Roxo")
        self.view.addSubview(text2)
        
        NSLayoutConstraint.activate([
            text2.topAnchor.constraint(equalTo: formulaInput.bottomAnchor, constant: 20),
            text2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            text2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func setRating() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        for i in 1...5 {
            let button = UIButton()
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
            starButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func ratingButtonTapped(_ sender: UIButton) {
        rating = sender.tag
        formula.rating = rating
        updateStarButtons()
    }
    
    private func updateStarButtons() {
        for button in starButtons {
            if button.tag <= rating {
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
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
