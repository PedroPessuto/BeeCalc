//
//  NumberView.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 23/05/24.
//

import UIKit

class NumberView: UIViewController {
    
    // ========== ATTRIBUTES ==========
    
    let formula: Formula
    let generalController: GeneralController = GeneralController.shared
    let update: @MainActor () async -> ()
    let header: UIView = UIView()
    let backButton: Button = Button(systemName: "house.fill")
    let input: UITextField = UITextField()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var result: String = ""
    var average: String = ""
    
    // ========== METHODS ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "CinzaClaro")
        if let average = formula.averageGrade {
            self.average = average
        }
        setElements()
    }
    
    private func setElements() {
        setToolbar()
        setScrollView()
        setStack()
        setSections()
    }
    
    @objc private func backButtonAction() {
        Task {
            formula.name = input.text ?? ""
            await update()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func updateFields() {
        print("oi")
        
    }
    
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
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setStack() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setSections() {
        stackView.addArrangedSubview(createSectionView())
    }
    
    private func createSectionView() -> UIView {
        let sectionView = UIView()
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.backgroundColor = .clear
        
        let media = createButton(title: "MÉDIA", number: formula.averageGrade)
        sectionView.addSubview(media)
        
        NSLayoutConstraint.activate([
            media.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 10),
            media.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 20),
            media.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -20),
            media.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let notasPonderadasView = createNotasSection(title: "Notas Ponderadas", description: "Notas que tem peso e serão divididas na média ponderada")
        sectionView.addSubview(notasPonderadasView)
        
        NSLayoutConstraint.activate([
            notasPonderadasView.topAnchor.constraint(equalTo: media.bottomAnchor, constant: 20),
            notasPonderadasView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 20),
            notasPonderadasView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -20)
        ])
        
        let notasAvulsasView = createNotasSection(title: "Notas Avulsas", description: "Notas que serão somadas a média")
        
        sectionView.addSubview(notasAvulsasView)
        
        NSLayoutConstraint.activate([
            notasAvulsasView.topAnchor.constraint(equalTo: notasPonderadasView.bottomAnchor, constant: 20),
            notasAvulsasView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 20),
            notasAvulsasView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -20)
        ])
        
        let resultadoButton = createButton(title: "RESULTADO", number: result)
        sectionView.addSubview(resultadoButton)
        
        NSLayoutConstraint.activate([
            resultadoButton.topAnchor.constraint(equalTo: notasAvulsasView.bottomAnchor, constant: 20),
            resultadoButton.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor, constant: 20),
            resultadoButton.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor, constant: -20),
            resultadoButton.heightAnchor.constraint(equalToConstant: 50),
            resultadoButton.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -20)
        ])
        
        return sectionView
    }
    
    private func createButton(title: String, number: String?) -> UIStackView {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.spacing = 20
        container.axis = .horizontal
        container.distribution = .fillEqually

        let leftContainer = UIView()
        leftContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(leftContainer)

        let rightContainer = UIView()
        rightContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(rightContainer)

        let textField = Input(text: number)
//        textField.text = formula.averageGrade
        textField.addTarget(self, action: #selector(updateFields), for: .editingChanged)

        rightContainer.addSubview(textField)

        leftContainer.backgroundColor = UIColor(named: "Verde")
        leftContainer.layer.cornerRadius = 10

        let titleLabel = MiniTitle(text: title)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftContainer.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: rightContainer.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor),
            textField.widthAnchor.constraint(equalTo: rightContainer.widthAnchor)
        ])

        return container
    }

   
    
    private func createNotasSection(title: String, description: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "Roxo")
        containerView.layer.cornerRadius = 10
        
        let titleLabel =  SubTitle(text: title)
        let paragraph = P(text: description)
        paragraph.translatesAutoresizingMaskIntoConstraints = false
        
        let addButton = Button(buttonText: "+", variant: .white)
        containerView.addSubview(titleLabel)
        containerView.addSubview(paragraph)
        containerView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 65),
            
            
            paragraph.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            paragraph.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            paragraph.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
            
        ])
        
        return containerView
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
