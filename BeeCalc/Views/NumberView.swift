//
//  NumberView.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 23/05/24.
//

import UIKit

//class NumberView: UIViewController, UITextFieldDelegate {
//    
//    // ========== ATTRIBUTES ==========
//    
//    let formula: Formula
//    let generalController: GeneralController = GeneralController.shared
//    let update: @MainActor () async -> ()
//    let header: UIView = UIView()
//    let backButton: Button = Button(systemName: "house.fill")
//    let input: UITextField = UITextField()
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//    
//    var result: String = ""
//    
//    // ========== METHODS ==========
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
//        setupView()
//    }
//    
//    private func setupView() {
//        view.backgroundColor = UIColor(named: "CinzaClaro")
//        setElements()
//    }
//    
//    private func setElements() {
//        setToolbar()
//        setScrollView()
//        setStack()
//    }
//    
//    @objc private func backButtonAction() {
//        Task {
//            formula.name = input.text ?? ""
//            await update()
//            navigationController?.popViewController(animated: true)
//        }
//    }
//    
//    @objc private func updateFields(_ sender: UITextField) {
//        if let _ = Float(sender.text ?? "") {
//            formula.averageGrade = sender.text ?? ""
//            Task {
//                await update()
//            }
//        }
//    }
//    
//    @objc private func updateGradeFields(_ sender: UITextField) {
//        
//        let index = sender.tag
//        print(index)
//        if index % 2 == 0 {
//            formula.weightedGrades[index] = sender.text ?? ""
//        } else {
//            formula.weightedGrades[index] = sender.text ?? ""
//        }
//        Task {
//            await update()
//        }
//    }
//    
//    @objc private func addSingleGrade() {
//        print("Adicionar uma nota avulsa")
//    }
//    
//    @objc private func dummyAction() {
//        // Método de ação dummy para o botão de Notas Ponderadas
//    }
//    
//    // ========== METHODS ==========
//    
//    private func setToolbar() {
//        self.view.addSubview(header)
//        header.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            header.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            header.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            header.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            header.heightAnchor.constraint(equalToConstant: 65)
//        ])
//        
//        // Back Button
//        header.addSubview(backButton)
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(backButtonAction))
//        backButton.addGestureRecognizer(backButtonTap)
//        
//        NSLayoutConstraint.activate([
//            backButton.widthAnchor.constraint(equalToConstant: 65),
//            backButton.heightAnchor.constraint(equalToConstant: 65),
//            backButton.leadingAnchor.constraint(equalTo: header.leadingAnchor)
//        ])
//        
//        // TextField
//        header.addSubview(input)
//        input.translatesAutoresizingMaskIntoConstraints = false
//        input.text = formula.name
//        input.backgroundColor = UIColor(named: "Cinza")
//        input.font = .systemFont(ofSize: 24, weight: .bold)
//        input.textColor = UIColor(named: "Roxo")
//        input.layer.cornerRadius = 10
//        input.textAlignment = .center
//        
//        NSLayoutConstraint.activate([
//            input.heightAnchor.constraint(equalToConstant: 65),
//            input.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
//            input.trailingAnchor.constraint(equalTo: header.trailingAnchor)
//        ])
//    }
//    
//    private func setScrollView() {
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//    
//    private func setStack() {
//        scrollView.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])
//        
//        let media = createButton(title: "MÉDIA", number: formula.averageGrade)
//        stackView.addArrangedSubview(media)
//        
//        let notasPonderadas = setNotasPonderadas()
//        stackView.addArrangedSubview(notasPonderadas)
//    }
//    
//    private func setSections() {
//        // stackView.addArrangedSubview(createSectionView())
//    }
//    
//    private func setNotasPonderadas() -> UIView {
//        
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        let notasPonderadasView = createNotasSection(title: "Notas Ponderadas", description: "Notas que tem peso e serão divididas na média ponderada", action: #selector(dummyAction))
//        view.addSubview(notasPonderadasView)
//        
//        NSLayoutConstraint.activate([
//            notasPonderadasView.topAnchor.constraint(equalTo: view.topAnchor),
//            notasPonderadasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            notasPonderadasView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        let textSection = createTextSection()
//        view.addSubview(textSection)
//        
//        NSLayoutConstraint.activate([
//            textSection.topAnchor.constraint(equalTo: notasPonderadasView.bottomAnchor, constant: 10),
//            textSection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            textSection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            textSection.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        
//        let gradeStack = UIStackView()
//        gradeStack.translatesAutoresizingMaskIntoConstraints = false
//        gradeStack.axis = .vertical
//        gradeStack.spacing = 20
//        
//        for index in formula.weightedGrades.indices {
//            if index % 2 != 0 {
//                continue
//            }
//            let gradeView = createGrade(firstText: formula.weightedGrades[index], secondText: formula.weightedGrades[index + 1], index: index)
//            gradeStack.addArrangedSubview(gradeView)
//        }
//       
//        
//        view.addSubview(gradeStack)
//        
//        NSLayoutConstraint.activate([
//            gradeStack.topAnchor.constraint(equalTo: textSection.bottomAnchor, constant: 20),
//            gradeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            gradeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        
//        return view
//    }
//    
//    private func createButton(title: String, number: String) -> UIView {
//        let view = UIView()
//        let container = UIStackView()
//        view.addSubview(container)
//        
//        container.translatesAutoresizingMaskIntoConstraints = false
//        container.spacing = 10
//        container.axis = .horizontal
//        container.distribution = .fillEqually
//
//        let leftContainer = UIView()
//        leftContainer.translatesAutoresizingMaskIntoConstraints = false
//        container.addArrangedSubview(leftContainer)
//
//        let textField = Input(text: number)
//        textField.addTarget(self, action: #selector(updateFields(_:)), for: .editingChanged)
//        textField.delegate = self
//
//        container.addArrangedSubview(textField)
//        
//        leftContainer.backgroundColor = UIColor(named: "Verde")
//        leftContainer.layer.cornerRadius = 10
//
//        let titleLabel = MiniTitle(text: title)
//        leftContainer.addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            titleLabel.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
//        ])
//
//        return container
//    }
//    
//    private func createNotasSection(title: String, description: String, action: Selector) -> UIView {
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = UIColor(named: "Roxo")
//        containerView.layer.cornerRadius = 10
//        
//        let titleLabel =  SubTitle(text: title)
//        let paragraph = P(text: description)
//        paragraph.translatesAutoresizingMaskIntoConstraints = false
//        
//        let addButton = Button(buttonText: "+", variant: .white)
//        containerView.addSubview(titleLabel)
//        containerView.addSubview(paragraph)
//        containerView.addSubview(addButton)
//        
//        let addButtonTap = UITapGestureRecognizer(target: self, action: action)
//        addButton.addGestureRecognizer(addButtonTap)
//        
//        NSLayoutConstraint.activate([
//            containerView.heightAnchor.constraint(equalToConstant: 120),
//            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
//            
//            addButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
//            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
//            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
//            addButton.widthAnchor.constraint(equalToConstant: 65),
//            
//            paragraph.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            paragraph.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
//            paragraph.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -20),
//        ])
//        
//        return containerView
//    }
//    
//    private func createTextSection() -> UIView {
//        let container = UIView()
//        container.translatesAutoresizingMaskIntoConstraints = false
//
//        let leftContainer = UIView()
//        leftContainer.translatesAutoresizingMaskIntoConstraints = false
//        leftContainer.backgroundColor = UIColor(named: "Amarelo")
//        leftContainer.layer.cornerRadius = 10
//        container.addSubview(leftContainer)
//
//        let titleLabel = MiniTitle(text: "VALOR")
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        leftContainer.addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            leftContainer.heightAnchor.constraint(equalToConstant: 50),
//            titleLabel.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor)
//        ])
//
//        let middleContainer = UIView()
//        middleContainer.translatesAutoresizingMaskIntoConstraints = false
//        middleContainer.backgroundColor = UIColor(named: "Roxo")
//        middleContainer.layer.cornerRadius = 10
//        container.addSubview(middleContainer)
//
//        let middleLabel = MiniTitle(text: "X")
//        middleLabel.translatesAutoresizingMaskIntoConstraints = false
//        middleContainer.addSubview(middleLabel)
//
//        NSLayoutConstraint.activate([
//            middleContainer.heightAnchor.constraint(equalToConstant: 50),
//            middleContainer.widthAnchor.constraint(equalToConstant: 40),
//            middleLabel.centerXAnchor.constraint(equalTo: middleContainer.centerXAnchor),
//            middleLabel.centerYAnchor.constraint(equalTo: middleContainer.centerYAnchor)
//        ])
//
//        let rightContainer = UIView()
//        rightContainer.translatesAutoresizingMaskIntoConstraints = false
//        rightContainer.backgroundColor = UIColor(named: "Amarelo")
//        rightContainer.layer.cornerRadius = 10
//        container.addSubview(rightContainer)
//
//        let rightTitleLabel = MiniTitle(text: "PESO")
//        rightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        rightContainer.addSubview(rightTitleLabel)
//
//        NSLayoutConstraint.activate([
//            rightContainer.heightAnchor.constraint(equalToConstant: 50),
//            rightTitleLabel.centerXAnchor.constraint(equalTo: rightContainer.centerXAnchor),
//            rightTitleLabel.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor)
//        ])
//
//        let trashContainer = UIView()
//        trashContainer.translatesAutoresizingMaskIntoConstraints = false
//        trashContainer.backgroundColor = UIColor(named: "Rosa")
//        trashContainer.layer.cornerRadius = 10
//        container.addSubview(trashContainer)
//
//        let image = UIImageView(image: UIImage(systemName: "trash.fill"))
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = UIColor.white
//        trashContainer.addSubview(image)
//
//        NSLayoutConstraint.activate([
//            trashContainer.heightAnchor.constraint(equalToConstant: 50),
//            trashContainer.widthAnchor.constraint(equalToConstant: 40),
//            image.centerXAnchor.constraint(equalTo: trashContainer.centerXAnchor),
//            image.centerYAnchor.constraint(equalTo: trashContainer.centerYAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            leftContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            leftContainer.trailingAnchor.constraint(equalTo: middleContainer.leadingAnchor, constant: -10),
//            middleContainer.trailingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: -10),
//            rightContainer.trailingAnchor.constraint(equalTo: trashContainer.leadingAnchor, constant: -10),
//            trashContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
//            
//            leftContainer.widthAnchor.constraint(equalTo: rightContainer.widthAnchor)
//        ])
//
//        return container
//    }
//    
//    private func createGrade(firstText: String, secondText: String, index: Int) -> UIView {
//        let container = UIView()
//        container.translatesAutoresizingMaskIntoConstraints = false
//
//        let leftContainer = Input(text: firstText)
//        leftContainer.tag = index
//        leftContainer.addTarget(self, action: #selector(updateGradeFields(_:)), for: .editingChanged)
//        container.addSubview(leftContainer)
//
//        NSLayoutConstraint.activate([
//            leftContainer.heightAnchor.constraint(equalToConstant: 50),
//        ])
//
//        let middleContainer = UIView()
//        middleContainer.translatesAutoresizingMaskIntoConstraints = false
//        middleContainer.backgroundColor = UIColor(named: "Roxo")
//        middleContainer.layer.cornerRadius = 10
//        container.addSubview(middleContainer)
//
//        let middleLabel = MiniTitle(text: "X")
//        middleLabel.translatesAutoresizingMaskIntoConstraints = false
//        middleContainer.addSubview(middleLabel)
//
//        NSLayoutConstraint.activate([
//            middleContainer.heightAnchor.constraint(equalToConstant: 50),
//            middleContainer.widthAnchor.constraint(equalToConstant: 40),
//            middleLabel.centerXAnchor.constraint(equalTo: middleContainer.centerXAnchor),
//            middleLabel.centerYAnchor.constraint(equalTo: middleContainer.centerYAnchor)
//        ])
//
//        let rightContainer = Input(text: secondText)
//        rightContainer.tag = index + 1
//        rightContainer.addTarget(self, action: #selector(updateGradeFields(_:)), for: .editingChanged)
//        container.addSubview(rightContainer)
//
//        NSLayoutConstraint.activate([
//            rightContainer.heightAnchor.constraint(equalToConstant: 50),
//        ])
//
//        let trashContainer = UIView()
//        trashContainer.translatesAutoresizingMaskIntoConstraints = false
//        trashContainer.backgroundColor = UIColor(named: "Rosa")
//        trashContainer.layer.cornerRadius = 10
//        container.addSubview(trashContainer)
//
//        let image = UIImageView(image: UIImage(systemName: "trash.fill"))
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = UIColor.white
//        trashContainer.addSubview(image)
//
//        NSLayoutConstraint.activate([
//            trashContainer.heightAnchor.constraint(equalToConstant: 50),
//            trashContainer.widthAnchor.constraint(equalToConstant: 40),
//            image.centerXAnchor.constraint(equalTo: trashContainer.centerXAnchor),
//            image.centerYAnchor.constraint(equalTo: trashContainer.centerYAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            leftContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//            leftContainer.trailingAnchor.constraint(equalTo: middleContainer.leadingAnchor, constant: -10),
//            middleContainer.trailingAnchor.constraint(equalTo: rightContainer.leadingAnchor, constant: -10),
//            rightContainer.trailingAnchor.constraint(equalTo: trashContainer.leadingAnchor, constant: -10),
//            trashContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
//            
//            leftContainer.widthAnchor.constraint(equalTo: rightContainer.widthAnchor)
//        ])
//
//        return container
//    }
//    
//    // ========== CONSTRUCTORS ==========
//    init(formula: Formula, update: @escaping @MainActor () async -> ()) {
//        self.formula = formula
//        self.update = update
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        return nil
//    }
//}
